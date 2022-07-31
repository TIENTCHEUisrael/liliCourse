from datetime import datetime
from re import S
from typing import Optional,TypeVar
from pydantic import BaseModel

T=TypeVar('T')

class responseSchema(BaseModel):
    code:str
    status:str
    message:str
    result:Optional[T]=None

class response(BaseModel):
    token:Optional[T]=None

class AdressSchema(BaseModel):
    id:int
    type:str
    taille:str
    poids:str
    price:int
    createdAt:datetime
    updatedAt:str
    adressLiv:Optional[T]=None
    adressRam:Optional[T]=None

class CommandeSchema(BaseModel):
    id:int
    userId:int
    createdAt:datetime
    updatedAt:str
    adressId:Optional[T]=None
   



