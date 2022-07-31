import secrets
from typing_extensions import Self
from requests import request
from db import app, register_tortoise
from fastapi import HTTPException, File
from fastapi.encoders import jsonable_encoder
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

#requete de get, put,post,delete
#................................................USER...............................................
#get
@app.get("/")
async def test():
    return {"hello":"world"}
#dependencies=[Depends(JWTBearer())], 
@app.get("/lilicourse/users",response_model=List[User_Pydantic])
async def get_all_user():
    retour= await User_Pydantic.from_queryset(User.all())
    return retour

@app.get("/lilicourse/user", response_model=UserIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def get_one_user(id: int):
    retour =await UserIn_Pydantic.from_queryset_single(User.get(user_id=id))
    return retour

@app.get("/lilicourse/user/login", response_model=User_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def Simplelogin(mail: str,passw:str):
    obj=User.get(password=passw,email=mail)
    retour =await User_Pydantic.from_queryset_single(obj)
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


@app.post("/lilicourse/user/image")
async def createFileUser(file: UploadFile = File(...)):
    filepath = "./static/user/"
    filename = file.filename
    extension = filename.split(".")[1]
    if extension not in ["png", "jpg","jpeg"]:
        return {"status": "error", "details": "File extension not allowed"}

    token_name = secrets.token_hex(5) + "." + extension
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


@app.post("/lilicourse/coursier/image")
async def create_Image_coursier(file: UploadFile = File(...)):
    filepath = "./static/coursier/"
    filename = file.filename
    extension = filename.split(".")[1]
    if extension not in ["png", "jpg","jpeg"]:
        return {"status": "error", "details": "File extension not allowed"}

    token_name = secrets.token_hex(5) + "." + extension
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



#put
@app.put("/lilicourse/user/update_user",response_model=UserIn_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(id:int,user:UserIn_Pydantic):
    await User.filter(user_id=id).update(**user.dict(exclude_unset=True))
    retour=await UserIn_Pydantic.from_queryset_single(User.get(user_id=id))
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


#..................................COURSIER.............................................;
#..................................ADRESSE .............................................;
#..................................ADRESSE_RAM..........................................;
#get
@app.get("/lilicourse/adressRam/{id}",response_model=Adresse_ram_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def getAdressRamById(id:int):
    model=await Adresse_ram_Pydantic.from_queryset_single(Adresse_ram.get(adresse_ram_id=id))
    return model

@app.get("/lilicourse/aressRam/",response_model=List[Adresse_ram_Pydantic])
async def getAdressRams():
    model=await Adresse_ram_Pydantic.from_queryset(User.all)
    return model

#post
@app.post("/lilicourse/adressRam/add",response_model=Adresse_ramIn_Pydantic)
async def addAdressRam(adres:Adresse_ramIn_Pydantic):
    obj=await Adresse_ram.create(**adres.dict(exclude_unset=True))
    return obj

#put
@app.put("/lilicourse/adressRam/put",response_model=Adresse_ram_Pydantic)
async def putAdressRam(id:int,adres:Adresse_ramIn_Pydantic):
    await Adresse_ram.filter(adresse_ram_id=id).update(**adres.dict(exclude_unset=True))
    obj=await Adresse_ram_Pydantic.from_queryset_single(Adresse_ram.get(adresse_ram_id=id))
    return obj

#delete
@app.delete("/lilicourse/adressRam/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_restaurant(id: int):
    delete_obj = await Adresse_ram.filter(adresse_ram_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

#..................................ADRESSE_LIV..........................................;


#..................................COMMANDE.............................................;
