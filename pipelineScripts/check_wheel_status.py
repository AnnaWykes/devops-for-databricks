import requests
import time
import os

DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/'+ os.environ['DBRKS_SUBSCRIPTION_ID'] +'/resourceGroups/'+ os.environ['DBRKS_RESOURCE_GROUP'] +'/providers/Microsoft.Databricks/workspaces/' + os.environ['DBRKS_WORKSPACE_NAME'],
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

DBRKS_CLUSTER_ID = {'cluster_id': os.environ["DBRKS_CLUSTER_ID"]}


def get_dbrks_libraries_status():
    DBRKS_LIBRARIES_ENDPOINT = 'api/2.0/libraries/cluster-status'
    response = requests.get("https://"+os.environ['DBRKS_INSTANCE']+".azuredatabricks.net/" + DBRKS_LIBRARIES_ENDPOINT, headers=DBRKS_REQ_HEADERS, params=DBRKS_CLUSTER_ID)
    if response.status_code != 200:
        raise Exception(response.content)
    else:
        return response.json()['library_statuses']


def get_dbrks_wheel_status():
    for library in get_dbrks_libraries_status():
        if 'whl' in library['library']:
            if str(library['library']['whl'].rsplit('/', 1)[1]).lower() == str("dfordbx-0.0.1-py3-none-any.whl").lower():
                return library['status']
    raise Exception('The following wheel is not present on the cluster: ' + str("dfordbx-0.0.1-py3-none-any.whl"))


def manage_dbrks_wheel_status():
    await_wheel = True
    WAITING_STATUSES = ['PENDING', 'RESOLVING', 'INSTALLING']
    FAILED_STATUSES = ['SKIPPED', 'FAILED']
    start_time = time.time()
    loop_time = 600  # 10 Minutes
    while await_wheel:
        current_time = time.time()
        elapsed_time = current_time - start_time
        # Instantiate wheel status so is not called multiple times in the same loop
        wheel_status = get_dbrks_wheel_status()
        if elapsed_time > loop_time:
            raise Exception('Error: Loop took over {a} seconds to run.'.format(a=loop_time))
        if wheel_status in WAITING_STATUSES:
            print('Wheel is: {a}'.format(a=wheel_status))
            time.sleep(30)
        elif wheel_status in FAILED_STATUSES:
            raise Exception('Wheel failed to install')
        else:
            print('Wheel Installed')
            await_wheel = False


manage_dbrks_wheel_status()
