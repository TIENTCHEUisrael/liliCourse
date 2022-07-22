from tortoise.contrib.fastapi import register_tortoise
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app=FastAPI(
    title="LiliCourseApi",
    description="Api of the project of the stage",
    version="1.0.0",
    terms_of_service="http://example.com/terms/",
    contact={
        "name": "Leicanor the Amazing",
        "url": "http://x-force.example.com/contact/",
        "email": "tientcheuisrael@gmail.com",
    },
    license_info={
        "name": "Apache 2.0",
        "url": "https://www.apache.org/licenses/LICENSE-2.0.html",
    },
    
)

origins=[
    "http://127.0.0.1:8000",
    "http://10.0.0.1:8000",
    "http://192.168.100.18",
    "http://192.168.1.103",
    "http://192.168.140.44"
    ]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#hostname -I  pour voir l'addresse ip
#uvicorn main:app  --reload --host 0.0.0.0 --port 8000   pour executer l'application 
#uvicorn main:app  --reload --host 192.168.100.18 --port 8000 pour le modem et tel
#uvicorn main:app  --reload --host 192.168.1.103 --port 8000 pour le modem et tel

register_tortoise(
    app,
    db_url="postgres://postgres:root@localhost/liliCourse",
    modules={'models':['models']},
    generate_schemas=True,
    add_exception_handlers=True
)
