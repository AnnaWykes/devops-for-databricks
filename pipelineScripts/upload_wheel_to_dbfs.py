import requests
import os

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

dbrks_rest_url = "https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/api/2.0/dbfs/put"

wheel_loaction = os.environ['SYSTEM_ARTIFACTSDIRECTORY'] + '/dfordbx-0.0.1-py3-none-any.whl'
print(wheel_loaction)

f = open(wheel_loaction, 'rb')
files = {"content": (wheel_loaction, f)}
response = requests.post(dbrks_rest_url, files=files, headers=DBRKS_REQ_HEADERS, data={'path': '/wheels/dfordbx-0.0.1-py3-none-any.whl', 'overwrite': 'true'})
if response.status_code == 200:
    print(response.status_code)
else:
    raise Exception(response.text)
