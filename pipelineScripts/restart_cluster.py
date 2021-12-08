import requests  # noqa: E902
import time
import os
import json

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_CLUSTER_ID = {'cluster_id': os.environ["DBRKS_CLUSTER_ID"]}


def get_dbrks_cluster_info():
    DBRKS_INFO_ENDPOINT = 'api/2.0/clusters/get'
    response = requests.get("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_INFO_ENDPOINT, headers=DBRKS_REQ_HEADERS, params=DBRKS_CLUSTER_ID)
    if response.status_code == 200:
        return json.loads(response.content)
    else:
        raise Exception(json.loads(response.content))


def start_dbrks_cluster():
    DBRKS_START_ENDPOINT = 'api/2.0/clusters/start'
    response = requests.post("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_START_ENDPOINT, headers=DBRKS_REQ_HEADERS, json=DBRKS_CLUSTER_ID)
    if response.status_code != 200:
        raise Exception(json.loads(response.content))


def restart_dbrks_cluster():
    DBRKS_RESTART_ENDPOINT = 'api/2.0/clusters/restart'
    response = requests.post(
        "https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_RESTART_ENDPOINT,
        headers=DBRKS_REQ_HEADERS,
        json=DBRKS_CLUSTER_ID)
    if response.status_code != 200:
        raise Exception(json.loads(response.content))
        

def manage_dbrks_cluster_state():
    await_cluster = True
    started_terminated_cluster = False
    cluster_restarted = False
    start_time = time.time()
    loop_time = 1200  # 20 Minutes
    while await_cluster:
        current_time = time.time()
        elapsed_time = current_time - start_time
        if elapsed_time > loop_time:
            raise Exception('Error: Loop took over {} seconds to run.'.format(loop_time))
        if get_dbrks_cluster_info()['state'] == 'TERMINATED':
            print('Starting Terminated Cluster')
            started_terminated_cluster = True
            start_dbrks_cluster()
            time.sleep(60)
        elif get_dbrks_cluster_info()['state'] == 'RESTARTING':
            print('Cluster is Restarting')
            time.sleep(60)
        elif get_dbrks_cluster_info()['state'] == 'PENDING':
            print('Cluster is Pending Start')
            time.sleep(60)
        elif get_dbrks_cluster_info()['state'] == 'RUNNING' and not cluster_restarted and not started_terminated_cluster:
            print('Restarting Cluster')
            cluster_restarted = True
            restart_dbrks_cluster()
        else:
            print('Cluster is Running')
            await_cluster = False


restart_dbrks_cluster()
manage_dbrks_cluster_state()
