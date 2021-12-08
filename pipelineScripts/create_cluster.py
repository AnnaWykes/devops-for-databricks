import requests  # noqa: E902
import time
import os
import json

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

print("DBRKS_REQ_HEADERS", DBRKS_REQ_HEADERS)

def create_cluster():
    DBRKS_START_ENDPOINT = 'api/2.0/clusters/create'
    postjson = """{
     "cluster_name": "devops-cluster",
     "spark_version": "7.3.x-scala2.12",
    "node_type_id": "Standard_DS3_v2",
    "autotermination_minutes": 10,
    "autoscale" : {
      "min_workers": 1,
      "max_workers": 3
    }
  }"""

    response = requests.post("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_START_ENDPOINT, headers=DBRKS_REQ_HEADERS, json=json.loads(postjson))
    if response.status_code != 200:
        raise Exception(response.text)
    
    os.environ["DBRKS_CLUSTER_ID"] = response.json()["cluster_id"]    
    print("##vso[task.setvariable variable=DBRKS_CLUSTER_ID;isOutput=true;]{b}".format(b=os.environ["DBRKS_CLUSTER_ID"]))
       

def list_clusters():
    DBRKS_ENDPOINT = 'api/2.0/clusters/list'
    response = requests.get("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_ENDPOINT, headers=DBRKS_REQ_HEADERS)
    if response.status_code != 200:
        raise Exception(response.content)
    else:
        return response.json()

def get_dbrks_cluster_info():
    DBRKS_CLUSTER_ID = {'cluster_id': os.environ["DBRKS_CLUSTER_ID"]}
    DBRKS_INFO_ENDPOINT = 'api/2.0/clusters/get'
    response = requests.get("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_INFO_ENDPOINT, headers=DBRKS_REQ_HEADERS, params=DBRKS_CLUSTER_ID)
    if response.status_code == 200:
        return json.loads(response.content)
    else:
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
            raise ValueError("Failed to create cluster, cluster teminated")
        elif get_dbrks_cluster_info()['state'] == 'RESTARTING':
            print('Cluster is Restarting')
            time.sleep(60)
        elif get_dbrks_cluster_info()['state'] == 'PENDING':
            print('Cluster is Pending Start')
            time.sleep(60)
        else:
            print('Cluster is Running')
            await_cluster = False

create_cluster()
manage_dbrks_cluster_state()

