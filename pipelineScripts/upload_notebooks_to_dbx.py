import requests
import os
from os.path import isfile, join
from os import listdir


dbrks_create_dir_url = "https://[databricks instance].azuredatabricks.net/api/2.0/workspace/mkdirs"
dbrks_import_rest_url = "https://[databricks instance].azuredatabricks.net/api/2.0/workspace/import"


DBRKS_REQ_HEADERS = {
    'Authorization': 'Bearer ' + os.environ['DBRKS_BEARER_TOKEN'],
    'X-Databricks-Azure-Workspace-Resource-Id': '/subscriptions/[subscriptionid]/resourceGroups/devopsfordatabricks/providers/Microsoft.Databricks/workspaces/[workspace name]',
    'X-Databricks-Azure-SP-Management-Token': os.environ['DBRKS_MANAGEMENT_TOKEN']}

notebooks = os.environ['DefaultWorkingDirectory'] + "/notebooks/"

        
path = notebooks
onlyfiles = [f for f in listdir(path) if isfile(join(path, f))]
for file in onlyfiles:
  fileLocation = path +"/"+ file 
  import base64
  data = open(fileLocation, "rb").read()
  encoded = base64.b64encode(data)
  files = {"content": (fileLocation,encoded)}
  if ".py" in file:
    fileName = file.split(".")[0]
    fileName = fileName.replace(".py", "")
    print(fileName)
    response = requests.post(dbrks_import_rest_url,headers=DBRKS_REQ_HEADERS, files=files, data={'path': '/DevOpsForDatabricks/' + fileName, 'language':'PYTHON','format':'SOURCE', 'overwrite': 'true', 'content': encoded})
      
  if response.status_code == 200:
      print(response.json)
  else:
      raise Exception(response.text)
