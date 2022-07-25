from datetime import datetime, timedelta
from typing import Optional
from fastapi.security import OAuth2PasswordBearer, HTTPBearer, HTTPAuthorizationCredentials
from fastapi import Depends ,Request,HTTPException
import jwt

#JWT configuration

SECRET_KEY="leicanorch1"
ALGORITM= "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES=30


class JWTRepo():
    def generate_token(data:dict,expires_delta:Optional[timedelta]=None):
        to_encode=data.copy()
        if expires_delta:
            expire=datetime.utcnow()+expires_delta
        else:
            expire=datetime.utcnow()+timedelta(minutes=15)
        to_encode.update({"exp":expire})
        encode_jwt=jwt.encode(to_encode,SECRET_KEY, algorithm=ALGORITM)
        return encode_jwt

    def decode_token(token:str):
        try:
            decode_token=jwt.decode(token,SECRET_KEY,algorithms=ALGORITM)
            return decode_token if decode_token["expires"]>=datetime.time() else None
        except:
            return

class JWTBearer(HTTPBearer):
    
    def __init__(self, auto_error:bool=True):
        super(JWTBearer,self).__init__(auto_error=auto_error)

    async def __call__(self, request: Request):

        Credentials =HTTPAuthorizationCredentials=await super(JWTBearer,self).__call__(request)
        if Credentials:
            if not Credentials.schema =="Bearer":
                raise HTTPException(status_code=400,detail="Invalide authentication scheme")
            if self.verify_jwt(Credentials.credentials):
                raise HTTPException(status_code=403,detail="Invalid token or expirred token")
            return Credentials.credentials
        else:
            raise HTTPException(status_code=403, detail="Invalid authentication code")

    def verify_jwt(Self, jwtoken:str):
        isTokenValid:bool =False

        try:
            payload=jwt.decode(jwtoken,SECRET_KEY,algorithms=ALGORITM)
        except:
            payload=None

        if payload:
            isTokenValid=True
        return isTokenValid