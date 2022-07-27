import secrets
from typing_extensions import Self
from requests import request
from db import app, register_tortoise
from fastapi import HTTPException, File
from fastapi.staticfiles import StaticFiles
from tortoise.contrib.fastapi import HTTPNotFoundError
from TokenGenerate import JWTRepo
from models import *
from pydantic import BaseModel
from pydantic.typing import List
from imagess import *
from schema import *
from PIL import Image
from passlib.context import CryptContext


#encrypt Password
pwd_context=CryptContext(schemes=["bcrypt"],deprecated="auto")


class Message(BaseModel):
    message:str

class TokenResponse(BaseModel):
    access_token:str
    token_type:str

list = []
print(list)

app.mount("/static", StaticFiles(directory="static"), name="static")

@app.post("/upload/profile")
async def create_upload_file(file: UploadFile = File(...)):
    filepath = "./static/images"
    filename = file.filename
    extension = filename.split(".")[1]
    if extension not in ["png", "jpg"]:
        return {"status": "error", "details": "File extension not allowed"}

    token_name = secrets.token_hex(10) + "." + extension
    generate_name = filepath + token_name
    file_content = await  file.read()
    with open(generate_name, "wb") as file:
        file.write(file_content)

        # PILLOW
        img = Image.open(generate_name)
        img.save(generate_name)
        file.close()
        # business = await Business.get(owner)
    file_url = generate_name[1:]
    return {"statut": "ok", "filename": file_url}

#requete de get, put,post,delete

#get
@app.get("/")
async def test():
    return {"hello":"world"}

@app.get("/lilicourse/users", response_model=List[User_Pydantic])
async def get_all_user():
    retour= await User_Pydantic.from_queryset(User.all())
    return retour

@app.get("/lilicourse/user", response_model=UserIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def get_one_user(id: int):
    retour =await UserIn_Pydantic.from_queryset_single(User.get(user_id=id))
    return retour

@app.get("/lilicourse/user/login", response_model=UserIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def Simplelogin(mail: str,passw:str):
    obj=User.get(password=passw,email=mail)
    retour =await UserIn_Pydantic.from_queryset_single(obj)
    return retour


@app.get('/lilicourse/user/getId')
async def getId(mail:str):
   obj=await User.get(email=mail)
   return {"user_id":obj.user_id}

#post
@app.post("/lilicourse/user/add_user",response_model=User_Pydantic)
async def simple_create_user(user:UserIn_Pydantic):
    obj=await User.create(**user.dict(exclude_unset=True))
    return await User_Pydantic.from_tortoise_orm(obj)



#put
@app.put("/lilicourse/user/update_user",response_model=UserIn_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(mail:str,user:UserIn_Pydantic):
    await User.filter(email=mail).update(**user.dict(exclude_unset=True))
    retour=await UserIn_Pydantic.from_queryset_single(User.get(email=mail))
    return retour


#essai token
@app.post('/lilicourse/user/generate')
async def generate_token(mail:str):
    try:        
        token=JWTRepo.generate_token({"sub":mail})
        return response(token=token).dict(exclude_none=True)
    except Exception as error:
        error_message=str(error.args)
        print(error_message)
        return responseSchema(code="500",status="alse",message="Error",token=TokenResponse(access_token=token,token_type="Bearer")).dict(exclude_none=True)

@app.get('/lilicourse/user/verify')
async def verify(token:str):
    try:        
        token=JWTRepo.decode_token(token)
        return response(token=token).dict(exclude_none=True)
    except Exception as error:
        error_message=str(error.args)
        print(error_message)
        return responseSchema(code="500",status="alse",message="sqdqsd",token=TokenResponse(access_token=token,token_type="Bearer")).dict(exclude_none=True)




