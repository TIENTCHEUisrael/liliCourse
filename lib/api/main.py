import email
from requests import request
from db import app, register_tortoise
from fastapi import HTTPException
from fastapi.staticfiles import StaticFiles
from tortoise.contrib.fastapi import HTTPNotFoundError
from TokenGenerate import JWTRepo
from models import *
from pydantic import BaseModel
from pydantic.typing import List
from imagess import *
from schema import *
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

#app.mount("/static", StaticFiles(directory="static"), name="static")

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
async def login_user(mail: str,passw:str):
    retour =await UserIn_Pydantic.from_queryset_single(User.get(password=passw,email=mail))
    return retour

@app.post("/lilicourse/user/loginUser")
async def tokengenerated(mail: str,passw:str):
    
    obj=await User.get(password=passw,email=mail)
    token=JWTRepo.generate_token({"sub":obj.email})

    return response(result=token).dict(exclude_none=True)
    #if not pwd_context.verify(passw,obj.password):
      #  return responseSchema(code="500",status="alse",message="Inivalid password").dict(exclude_none=True)


#post
@app.post("/lilicourse/user/add_user",response_model=User_Pydantic)
async def create_user(user:UserIn_Pydantic):
    obj=await User.create(**user.dict(exclude_unset=True))
    print(obj)
    return await User_Pydantic.from_tortoise_orm(obj)


#put
@app.put("/lilicourse/user/update_user",response_model=User_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(mail:str,user:UserIn_Pydantic):
    await User.filter(email=mail).update(**user.dict(exclude_unset=True))
    retour=await User_Pydantic.from_queryset_single(User.get(email=mail))
    return retour























#essai token
@app.post('/log')
async def token_essai():
    try:        
        token=JWTRepo.generate_token({"sub":"sdfsdf"})
        return responseSchema(code="200",status="succes",message="sqdqsd",result=TokenResponse(access_token=token,token_type="Bearer")).dict(exclude_none=True)
    except Exception as error:
        error_message=str(error.args)
        print(error_message)
        return responseSchema(code="500",status="alse",message="sqdqsd",result=TokenResponse(access_token=token,token_type="Bearer")).dict(exclude_none=True)