# devops-for-databricks


## To run the Demo

1.	Upload the .dbc file to Databricks Repo
2.	Create a project in Azure DevOps called: devops-for-databricks
3.	Create an Empty (no Readme.md) repo 
4.	Connect the Databricks Repo to Azure DevOps Repo
5.	Commit 
6.	Create an Azure KeyVault with the variables stated below
7.	Create a Variable Group in Pipeline->Library called: devops-for-dbx-vg
8.	Connect the Variable Group to the Azure Keyvault and add all the variables
9.	Create an Azure Artifact feed called: devops-for-databricks
20.	Run the Pipeline


## Pipeline will need a Azure Secret Vault with the following secrets.
<br>
***DBXInstance***: Databricks instance, eg: adb-631237481529976.16<br>
***ResourceGroup***: Resource Group where Databricks instance is<br>
***SubscriptionID***: Subscription ID where everything runs in Azure<br>
***SVCApplicationID***: Application (client) ID for the Service Principal<br>
***SVCDirectoryID***: Directory (tenant) ID for the Service Principal<br>
***SVCSecretKey***: Secret value for the Service Principal<br>
***WorkspaceName***: Name of the Databricks Workspace<br>

