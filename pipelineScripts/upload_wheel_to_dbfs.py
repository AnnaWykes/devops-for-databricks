import requests
import os

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/[subscriptionid]/resourceGroups/devopsfordatabricks/providers/Microsoft.Databricks/workspaces/[workspacename]',
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

dbrks_rest_url = "https://[databricks instance].azuredatabricks.net/api/2.0/dbfs/put"

wheel_loaction = os.environ['DefaultWorkingDirectory'] + '/wheel/dist/dfordbx-0.0.1-py3-none-any.whl'
print(wheel_loaction)

f = open(wheel_loaction, 'rb')
files = {"content": (wheel_loaction, f)}
response = requests.post(dbrks_rest_url, files=files, headers=DBRKS_REQ_HEADERS, data={'path': '/wheels/dfordbx-0.0.1-py3-none-any.whl', 'overwrite': 'true'})
if response.status_code == 200:
    print(response.status_code)
else:
    raise Exception(response.text)
