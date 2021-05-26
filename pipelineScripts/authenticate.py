import requests
import json
import os

TOKEN_REQ_BODY = {
       'grant_type': 'client_credentials',
       'client_id': os.environ['SVCApplicationID'],
       'client_secret': os.environ['SVCSecretKey']}
SVC_DIRECTORY_ID = os.environ['SVCDirectoryID']
TOKEN_BASE_URL = 'https://login.microsoftonline.com/' + SVC_DIRECTORY_ID + '/oauth2/token'
TOKEN_REQ_HEADERS = {'Content-Type': 'application/x-www-form-urlencoded'}



def dbrks_management_token():
        TOKEN_REQ_BODY['resource'] = 'https://management.core.windows.net/'
        response = requests.get(TOKEN_BASE_URL, headers=TOKEN_REQ_HEADERS, data=TOKEN_REQ_BODY)
        if response.status_code == 200:
            print(response.status_code)
        else:
            raise Exception(response.text)
        return response.json()['access_token']


def dbrks_bearer_token():
        TOKEN_REQ_BODY['resource'] = '2ff814a6-3304-4ab8-85cb-cd0e6f879c1d'
        response = requests.get(TOKEN_BASE_URL, headers=TOKEN_REQ_HEADERS, data=TOKEN_REQ_BODY)
        if response.status_code == 200:
            print(response.status_code)
        else:
            raise Exception(response.text)
        return response.json()['access_token']

DBRKS_BEARER_TOKEN = dbrks_bearer_token()
DBRKS_MANAGEMENT_TOKEN = dbrks_management_token()

os.environ['DBRKS_BEARER_TOKEN'] = DBRKS_BEARER_TOKEN 
os.environ['DBRKS_MANAGEMENT_TOKEN'] = DBRKS_MANAGEMENT_TOKEN 

dbrks_bearer_token()
print(os.environ['DBRKS_BEARER_TOKEN'])
print(os.environ['DBRKS_MANAGEMENT_TOKEN'])
