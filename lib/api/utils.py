from passlib.context import CryptContext
import os
from datetime import datetime, timedelta
from typing import Union, Any
from jose import jwt

ACCESS_TOKEN_EXPIRE_MINUTES = 30  # 30 minutes
REFRESH_TOKEN_EXPIRE_MINUTES = 60 * 24 * 7 # 7 days
ALGORITHM = "HS256"
JWT_SECRET_KEY = os.environ['JWT_SECRET_KEY']     # should be kept secret
JWT_REFRESH_SECRET_KEY = os.environ['JWT_REFRESH_SECRET_KEY']      # should be kept secret

password_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_hashed_password(password: str) -> str:
    return password_context.hash(password)


def verify_password(password: str, hashed_pass: str) -> bool:
    return password_context.verify(password, hashed_pass)


def create_access_token(subject: Union[str, Any], expires_delta: int = None) -> str:
    if expires_delta is not None:
        expires_delta = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode = {"exp": expires_delta, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET_KEY, ALGORITHM)
    return encoded_jwt

def create_refresh_token(subject: Union[str, Any], expires_delta: int = None) -> str:
    if expires_delta is not None:
        expires_delta = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=REFRESH_TOKEN_EXPIRE_MINUTES)
    
    to_encode = {"exp": expires_delta, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, JWT_REFRESH_SECRET_KEY, ALGORITHM)
    return encoded_jwt

    #Dans le app/app.pyfichier, créez un autre point de terminaison pour gérer les inscriptions des utilisateurs. Le point de terminaison doit prendre le nom d'utilisateur/e-mail et le mot de passe comme données. Il vérifie ensuite qu'un autre compte avec l'adresse e-mail/nom d'utilisateur n'existe pas. Ensuite, il crée l'utilisateur et l'enregistre dans la base de données.

@app.post('/signup', summary="Create new user", response_model=User_Pydantic)
async def create_user(data: UserIn_Pydantic):
    # querying database to check if user already exist
    user = User.get(data.email, None)
    if user is not None:
            raise HTTPException(
            status_code=Status.HTTP_400_BAD_REQUEST,
            detail="User with this email already exist"
        )    
    user = {
        'first_name': data.first_name,
        'last_name': data.last_name,
        'email': data.email,
        'phone_number': data.phone_number,
        'password': get_hashed_password(data.password),
        'commentaire': data.commentaire,
        'image': data.image
    }
    User[data.email] = user    # saving user to database
    return await User_Pydantic.from_tortoise_orm(user)