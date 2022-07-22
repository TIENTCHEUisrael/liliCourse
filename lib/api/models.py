from sqlalchemy import null, table
import bcrypt
from typing import Optional
from tortoise import fields
from tortoise.models import Model
from tortoise.contrib.pydantic import pydantic_model_creator

class User(Model):
    user_id=fields.IntField(pk=True)
    first_name=fields.CharField(null=False,unique=True,max_length=255)
    last_name=fields.CharField(null=False,unique=True,max_length=255)
    email=fields.CharField(null=False,unique=True,max_length=255)
    phone_number=fields.IntField()
    password=fields.CharField(null=False,max_length=255)
    commentaire=fields.CharField(max_length=255)
    image=fields.CharField(null=True,max_length=250)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    def verify_password(self, password):
        return bcrypt.verify(password, self.password_hash)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='User'

User_Pydantic=pydantic_model_creator(User,name="User")
UserIn_Pydantic=pydantic_model_creator(User,name="UserIn",exclude_readonly=True)


class Coursier(Model):
    coursier_id=fields.IntField(pk=True)
    user_id=fields.IntField()
    commande_id=fields.IntField()
    transport=fields.CharField(max_length=255)
    rating=fields.FloatField()
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Coursier'

Coursier_Pydantic=pydantic_model_creator(Coursier,name="Coursier")
CoursierIn_Pydantic=pydantic_model_creator(Coursier,name="CoursierIn",exclude_readonly=True)


class Partenaire(Model):
    partenaire_id=fields.IntField(pk=True)
    user_id=fields.IntField()
    name_societe=fields.CharField(max_length=255)
    secteurs=fields.CharField(max_length=255)
    country=fields.CharField(max_length=255)
    postal_code=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Partenaire'

Partenaire_Pydantic=pydantic_model_creator(Partenaire,name="Partenaire")
PartenaireIn_Pydantic=pydantic_model_creator(Partenaire,name="PartenaireIn",exclude_readonly=True)


class Commande(Model):
    commande_id=fields.IntField(pk=True)
    user_id=fields.IntField()
    adresse_id=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Commande'

Commande_Pydantic=pydantic_model_creator(Commande,name="Commande")
CommandeIn_Pydantic=pydantic_model_creator(Commande,name="CommandeIn",exclude_readonly=True)


class Adresse(Model):
    adresse_id=fields.IntField(pk=True)
    adresse_liv_id=fields.IntField()
    adresse_ram_id=fields.IntField()
    poids=fields.CharField(max_length=255)
    taille=fields.CharField(max_length=255)
    type=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Adresse'

Adresse_Pydantic=pydantic_model_creator(Adresse,name="Adresse")
AdresseIn_Pydantic=pydantic_model_creator(Adresse,name="AdresseIn",exclude_readonly=True)


class Adresse_ram(Model):
    adresse_ram_id=fields.IntField(pk=True)
    localisation=fields.CharField(max_length=255)
    name_recepteur=fields.CharField(max_length=255)
    contact_recepteur=fields.IntField()
    email_recepteur=fields.CharField(max_length=255)
    civilite_recepteur=fields.CharField(max_length=255)
    planification=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Adresse_ram'

Adresse_ram_Pydantic=pydantic_model_creator(Adresse_ram,name="Adresse_ram")
Adresse_ramIn_Pydantic=pydantic_model_creator(Adresse_ram,name="Adresse_ramIn",exclude_readonly=True)


class Adresse_liv(Model):
    adresse_liv_id=fields.IntField(pk=True)    
    localisation=fields.CharField(max_length=255)
    name=fields.CharField(max_length=255)
    contact=fields.IntField()
    email=fields.CharField(max_length=255)
    civilite=fields.CharField(max_length=255)
    instruction=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Adresse_liv'

Adresse_liv_Pydantic=pydantic_model_creator(Adresse_liv,name="Adresse_liv")
Adresse_livIn_Pydantic=pydantic_model_creator(Adresse_liv,name="Adresse_livIn",exclude_readonly=True)



class Paiement(Model):
    paiementt_id=fields.IntField(pk=True)
    user_id=fields.IntField()
    comande_id=fields.CharField(max_length=255)
    montant=fields.FloatField()
    mode=fields.CharField(max_length=255)
    code=fields.CharField(max_length=255)
    updated_at=fields.DatetimeField(auto_now=True)
    created_at=fields.DatetimeField(auto_now_add=True)

    class PydanticMeta:
        pass
    
    class Meta:
        table:str='Paiement'

APaiement_Pydantic=pydantic_model_creator(Paiement,name="Paiement")
PaiementIn_Pydantic=pydantic_model_creator(Paiement,name="PaiementIn",exclude_readonly=True)
