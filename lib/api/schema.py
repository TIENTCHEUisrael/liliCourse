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

