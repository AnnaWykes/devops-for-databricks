import requests  # noqa: E902
import time
import os
import json

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_CLUSTER_ID = {'cluster_id': os.environ["DBRKS_CLUSTER_ID"]}

def delete_dbrks_cluster():
    DBRKS_RESTART_ENDPOINT = 'api/2.0/clusters/permanent-delete'
    response = requests.post(
        "https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_RESTART_ENDPOINT,
        headers=DBRKS_REQ_HEADERS,
        json=DBRKS_CLUSTER_ID)
    if response.status_code != 200:
        raise Exception(json.loads(response.content))

        
delete_dbrks_cluster()
