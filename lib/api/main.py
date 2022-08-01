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

#put
@app.put("/lilicourse/user/update_user",response_model=UserIn_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(id:int,user:UserIn_Pydantic):
    await User.filter(user_id=id).update(**user.dict(exclude_unset=True))
    retour=await UserIn_Pydantic.from_queryset_single(User.get(user_id=id))
    return retour

#delete
@app.delete("/lilicourse/user/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_adress(id: int):
    delete_obj = await Commande.filter(commande_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

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
#.......................................................................................
#get

#dependencies=[Depends(JWTBearer())], 
@app.get("/lilicourse/coursiers",response_model=List[Coursier_Pydantic])
async def get_all_coursier():
    retour= await Coursier_Pydantic.from_queryset(Coursier.all())
    return retour

@app.get("/lilicourse/coursier", response_model=CoursierIn_Pydantic, responses={404: {"model": HTTPNotFoundError}})
async def get_one_coursier(id: int):
    retour =await CoursierIn_Pydantic.from_queryset_single(Coursier.get(coursier_id=id))
    return retour

#post
@app.post("/lilicourse/coursier/add_coursier",response_model=Coursier_Pydantic)
async def simple_create_user(cours:CoursierIn_Pydantic):
    obj=await Coursier.create(**cours.dict(exclude_unset=True))
    return await Coursier_Pydantic.from_tortoise_orm(obj)

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
@app.put("/lilicourse/coursier/update_coursier",response_model=CoursierIn_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def update_user(id:int,cours:CoursierIn_Pydantic):
    await Coursier.filter(coursier_id=id).update(**cours.dict(exclude_unset=True))
    retour=await CoursierIn_Pydantic.from_queryset_single(Coursier.get(coursier_id=id))
    return retour

#delete
@app.delete("/lilicourse/coursier/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_adress(id: int):
    delete_obj = await Commande.filter(commande_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

#..................................ADRESSE .............................................;
#........................................................................................
#get
@app.get("/lilicourse/adress/{id}",response_model=Adresse_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def getAdressById(id:int):
    model=await Adresse_Pydantic.from_queryset_single(Adresse.get(adresse_id=id))
    return model

@app.get("/lilicourse/adress/",response_model=List[Adresse_Pydantic])
async def getAdress():
    model=await Adresse_Pydantic.from_queryset(Adresse.all)
    return model

#post
@app.post("/lilicourse/adress/add",response_model=Adresse_Pydantic)
async def addAdress(adres:AdresseIn_Pydantic):
    obj=await Adresse_ram.create(**adres.dict(exclude_unset=True))
    return obj

#put
@app.put("/lilicourse/adress/put",response_model=Adresse_Pydantic)
async def putAdress(id:int,adres:AdresseIn_Pydantic):
    await Adresse.filter(adresse_id=id).update(**adres.dict(exclude_unset=True))
    obj=await Adresse_Pydantic.from_queryset_single(Adresse.get(adresse_id=id))
    return obj

#delete
@app.delete("/lilicourse/adress/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_adress(id: int):
    delete_obj = await Adresse.filter(adresse_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

#..................................ADRESSE_RAM..........................................;
#.......................................................................................
#get
@app.get("/lilicourse/adressRam/{id}",response_model=Adresse_ram_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def getAdressRamById(id:int):
    model=await Adresse_ram_Pydantic.from_queryset_single(Adresse_ram.get(adresse_ram_id=id))
    return model

@app.get("/lilicourse/adressRam/",response_model=List[Adresse_ram_Pydantic])
async def getAdressRams():
    model=await Adresse_ram_Pydantic.from_queryset(Adresse_ram.all)
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
async def delete_adressRam(id: int):
    delete_obj = await Adresse_ram.filter(adresse_ram_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

#..................................ADRESSE_LIV..........................................;
#........................................................................................
#get
@app.get("/lilicourse/adressLiv/{id}",response_model=Adresse_liv_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def getAdressLivById(id:int):
    model=await Adresse_liv_Pydantic.from_queryset_single(Adresse_liv.get(adresse_liv_id=id))
    return model

@app.get("/lilicourse/adressLiv/",response_model=List[Adresse_liv_Pydantic])
async def getAdressLiv():
    model=await Adresse_liv_Pydantic.from_queryset(Adresse_liv.all)
    return model

#post
@app.post("/lilicourse/adressLiv/add",response_model=Adresse_liv_Pydantic)
async def addAdressLiv(adres:Adresse_livIn_Pydantic):
    obj=await Adresse_liv.create(**adres.dict(exclude_unset=True))
    return obj

#put
@app.put("/lilicourse/adressLiv/put",response_model=Adresse_liv_Pydantic)
async def putAdressLiv(id:int,adres:Adresse_livIn_Pydantic):
    await Adresse_liv.filter(adresse_ram_id=id).update(**adres.dict(exclude_unset=True))
    obj=await Adresse_liv_Pydantic.from_queryset_single(Adresse_liv.get(adresse_liv_id=id))
    return obj

#delete
@app.delete("/lilicourse/adressLiv/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_adressLiv(id: int):
    delete_obj = await Adresse_liv.filter(adresse_liv_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")

#..................................COMMANDE.............................................;
#........................................................................................
#get
@app.get("/lilicourse/commande/{id}",response_model=Commande_Pydantic,responses={404: {"model": HTTPNotFoundError}})
async def getcommandeById(id:int):
    model=await Commande_Pydantic.from_queryset_single(Commande.get(commande_id=id))
    return model

@app.get("/lilicourse/commande/",response_model=List[Commande_Pydantic])
async def getcommandes():
    model=await Commande_Pydantic.from_queryset(Commande.all)
    return model

#post
@app.post("/lilicourse/commande/add",response_model=Commande_Pydantic)
async def addcommande(com:CommandeIn_Pydantic):
    obj=await Commande.create(**com.dict(exclude_unset=True))
    return obj

#put
@app.put("/lilicourse/commande/put",response_model=Commande_Pydantic)
async def putcommande(id:int,comm:CommandeIn_Pydantic):
    await Commande.filter(commande_id=id).update(**comm.dict(exclude_unset=True))
    obj=await Commande_Pydantic.from_queryset_single(Commande.get(commande_id=id))
    return obj

#delete
@app.delete("/lilicourse/commande/{id}", response_model=Message, responses={404: {"model": HTTPNotFoundError}})
async def delete_commande(id: int):
    delete_obj = await Commande.filter(commande_id=id).delete()
    if not delete_obj:
        raise HTTPException(status_code=404, detail="this restaurant, is not found")
    return Message(message="Succesfully deleted")
