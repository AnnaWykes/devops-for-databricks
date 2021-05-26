import requests
import os


DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/6392d180-7beb-4851-8c38-8d32bb52555f/resourceGroups/devopsfordatabricks/providers/Microsoft.Databricks/workspaces/devopsfordatabricks_dbx',
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_REQ_BODY = {'cluster_id': '0423-124042-plugs864', 'libraries': [{'whl': 'dbfs:/wheels/dfordbx-0.0.1-py3-none-any.whl'}]}

DBRKS_INSTALL_ENDPOINT = 'api/2.0/libraries/install'

response = requests.post(
    "https://adb-3843427314946365.5.azuredatabricks.net/" + DBRKS_INSTALL_ENDPOINT,
    headers=DBRKS_REQ_HEADERS,
    json=DBRKS_REQ_BODY)

if response.status_code != 200:
    raise Exception(response.content)
else:
    print(response.status_code)
