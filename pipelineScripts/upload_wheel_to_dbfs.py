import requests
import os

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/6392d180-7beb-4851-8c38-8d32bb52555f/resourceGroups/devopsfordatabricks/providers/Microsoft.Databricks/workspaces/devopsfordatabricks_dbx',
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

dbrks_rest_url = "https://adb-3843427314946365.5.azuredatabricks.net/api/2.0/dbfs/put"

wheel_loaction = os.environ['DefaultWorkingDirectory'] + '/wheel/dist/dfordbx-0.0.1-py3-none-any.whl'
print(wheel_loaction)

f = open(wheel_loaction, 'rb')
files = {"content": (wheel_loaction, f)}
response = requests.post(dbrks_rest_url, files=files, headers=DBRKS_REQ_HEADERS, data={'path': '/wheels/dfordbx-0.0.1-py3-none-any.whl', 'overwrite': 'true'})
if response.status_code == 200:
    print(response.status_code)
else:
    raise Exception(response.text)
