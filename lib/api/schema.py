from re import S
from typing import Optional,TypeVar
from xmlrpc.client import DateTime
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
    createdAt:DateTime
    updatedAt:str
    adressLiv:Optional[T]=None
    adressRam:Optional[T]=None

class CommandeSchema(BaseModel):
    id:int
    userId:int
    adressId:Optional[T]=None
    createdAt:DateTime
    updatedAt:str



