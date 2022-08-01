import http.client, urllib.request, urllib.parse, urllib.error, base64
import json
import requests
import sys

phone = "12333"
amound ="123333"



content_type = 'application/json'
x_reference_id = '80d310f2-fe7d-4f3c-9e3a-184b49a29935'
ocp_Apim_subscription_Key = 'a2b909d218e1477ba010515c92562a47'
x_target_environment = 'sandbox'


#Authanticate User
def authenticate_user(content_type, x_reference_id, ocp_Apim_subscription_Key):
    headers = {
    # Request headers
    'X-Reference-Id':x_reference_id,
    'Content-Type':content_type,
    'Ocp-Apim-Subscription-Key':ocp_Apim_subscription_Key
    }

    body = {"providerCallbackHost": "google.com"}

    try:
        response = requests.post("https://sandbox.momodeveloper.mtn.com/v1_0/apiuser?",headers = headers, data=json.dumps(body))
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))



#generate Api Key
def generate_api_key(x_reference_id, ocp_Apim_subscription_Key):
    headers = {
    # Request headers
    'Ocp-Apim-Subscription-Key': ocp_Apim_subscription_Key,
    }
    params = urllib.parse.urlencode({
    })
    try:
        conn = http.client.HTTPSConnection('sandbox.momodeveloper.mtn.com')
        conn.request("POST", "/v1_0/apiuser/{}/apikey?%s".format(x_reference_id) % params, "{body}", headers)
        response = conn.getresponse()
        key = response.read()
        key = key.decode("utf-8")
        key = json.loads(key)
        key = key['apiKey']
        key = base64.b64encode('{}:{}'.format(x_reference_id,key).encode('utf-8'))
        key = 'Basic {}'.format(key.decode("utf-8"))
        conn.close()
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))
    return key



#get Tokent
def get_token(ocp_Apim_subscription_Key, key):
    headers = {
    # Request headers
    'Authorization': key,
    'Ocp-Apim-Subscription-Key': ocp_Apim_subscription_Key,
}

    params = urllib.parse.urlencode({
})
    try:
        conn = http.client.HTTPSConnection('sandbox.momodeveloper.mtn.com')
        conn.request("POST", "/collection/token/?%s" % params, "", headers)
        response = conn.getresponse()
        resp_dict = response.read()
        resp_dict = resp_dict.decode("utf-8")
        resp_dict = json.loads(resp_dict)
        access_token = resp_dict['access_token']
        conn.close()
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))
    return access_token



#Start transaction
def requesttopay(
                  content_type,
                  x_reference_id,
                  ocp_Apim_subscription_Key,
                  x_target_environment='sandbox',
                  amount='1000',
                  phone_number='677111143',
                  currency='EUR',
                  externalId='1234',
                  country_code='237',
                  partyIdType = 'MSISDN',
                  payerMessage = 'string',
                  payeeNote ='string' ,
                ):
    authenticate_user(content_type, x_reference_id, ocp_Apim_subscription_Key)
    key = generate_api_key(x_reference_id, ocp_Apim_subscription_Key)
    access_token = get_token(ocp_Apim_subscription_Key, key)
    access_token = 'Bearer {}'.format(access_token)
    headers = {
    # Request headers
    'Authorization': access_token,
    'X-Reference-Id': x_reference_id,
    'X-Target-Environment':x_target_environment,
    'Content-Type': content_type,
    'Ocp-Apim-Subscription-Key': ocp_Apim_subscription_Key,
}

    body = {
  "amount": amount,
  "currency": currency,
  "externalId": externalId,
  "payer": {
    "partyIdType": partyIdType,
    "partyId": country_code+phone_number
  },
  "payerMessage": payerMessage,
  "payeeNote": payeeNote,
}

    try:
        response = requests.post("https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay?",headers = headers, data=json.dumps(body))
        return response.status_code
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))


print(requesttopay(content_type, x_reference_id, ocp_Apim_subscription_Key, x_target_environment,amount=amound,phone_number=phone))
