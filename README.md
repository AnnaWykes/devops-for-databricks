# devops-for-databricks


## To run the Demo
	
1.	Create a project in Azure DevOps called: devops-for-databricks
2.	Create an Empty Azure DevOps Repo as clone of this Github repo
3.	Create an Azure KeyVault with the variables stated below
4.	Create a Variable Group in Pipeline->Library called: devops-for-dbx-vg
5.	Connect the Variable Group to the Azure Keyvault and add all the variables
6.	Create an Azure Artifact feed called: devops-for-databricks
7.	Run the Pipeline


## The Pipeline will need an Azure Secret Vault with the following secrets.<br>

***DBXInstance***: Databricks instance, eg: adb-631237481529976.16<br>
***ResourceGroup***: Resource Group where Databricks instance is<br>
***SubscriptionID***: Subscription ID where everything runs in Azure<br>
***SVCApplicationID***: Application (client) ID for the Service Principal<br>
***SVCDirectoryID***: Directory (tenant) ID for the Service Principal<br>
***SVCSecretKey***: Secret value for the Service Principal<br>
***WorkspaceName***: Name of the Databricks Workspace<br>

## Pipeline Run Example<br>
![Pipeline Run Sample!](/pipeline-screenshot.png "Pipeline Run Sample")
