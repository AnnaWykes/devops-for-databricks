import requests
import os


DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/[subscriptionId]/resourceGroups/devopsfordatabricks/providers/Microsoft.Databricks/workspaces/[workspace name]',
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_REQ_BODY = {'cluster_id': '[clusterid]', 'libraries': [{'whl': 'dbfs:/wheels/dfordbx-0.0.1-py3-none-any.whl'}]}

DBRKS_INSTALL_ENDPOINT = 'api/2.0/libraries/install'

response = requests.post(
    "https://[databricks instance].azuredatabricks.net/" + DBRKS_INSTALL_ENDPOINT,
    headers=DBRKS_REQ_HEADERS,
    json=DBRKS_REQ_BODY)

if response.status_code != 200:
    raise Exception(response.content)
else:
    print(response.status_code)
