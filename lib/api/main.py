from email import message
import email
from db import app, register_tortoise
from fastapi import HTTPException
from fastapi.staticfiles import StaticFiles
from tortoise.contrib.fastapi import HTTPNotFoundError
from models import *
from pydantic import BaseModel
from pydantic.typing import List
from PIL import Image


class Message(BaseModel):
    message:str

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
    return await User_Pydantic.from_queryset(User.all())

@app.get("/lilicourse/user", response_model=UserIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def get_one_user(id: int):
    retour =await UserIn_Pydantic.from_queryset_single(User.get(user_id=id))
    return retour


@app.get("/lilicourse/user/login", response_model=UserIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def login_user(mail: str,passw:str):
    retour =await UserIn_Pydantic.from_queryset_single(User.get(password=passw,email=mail))
    return retour


#post
@app.post("/lilicourse/add_user",response_model=User_Pydantic)
async def create_user(user:UserIn_Pydantic):
    obj=await User.create(**user.dict(exclude_unset=True))
    print(obj)
    return await User_Pydantic.from_tortoise_orm(obj)

#put
@app.put("/lilicourse/update_user{id}",response_model=User_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(id:int,user:UserIn_Pydantic):
    await User.filter(user_id=id).update(**user.dict(exclude_unset=True))
    retour=await User_Pydantic.from_queryset_single(User.get(user_id=id))
    return retour
