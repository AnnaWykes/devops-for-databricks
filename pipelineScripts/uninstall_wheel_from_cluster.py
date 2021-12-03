import requests
import json
import os

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_REQ_BODY = {
    'cluster_id': os.environ["DBRKS_CLUSTER_ID"],
    'libraries': [{'whl': 'dbfs:/wheels/' + 'dfordbx-0.0.1-py3-none-any.whl'}]}

DBRKS_UNINSTALL_ENDPOINT = 'api/2.0/libraries/uninstall'

response = requests.post(
    "https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_UNINSTALL_ENDPOINT, headers=DBRKS_REQ_HEADERS, json=DBRKS_REQ_BODY
)
if response.status_code != 200:
    print(response.content)
    raise Exception(response)
else:
    print(response.status_code)
