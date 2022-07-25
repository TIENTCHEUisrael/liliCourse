from typing import Optional,TypeVar
from unittest import result
from pydantic import BaseModel

T=TypeVar('T')

class responseSchema(BaseModel):
    code:str
    status:str
    message:str
    result:Optional[T]=None

class response(BaseModel):
    result:Optional[T]=None