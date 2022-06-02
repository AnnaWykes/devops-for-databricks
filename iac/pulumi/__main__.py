from pulumi_azure_native import storage
from pulumi_azure_native import resources
from pulumi_azure_native import databricks as dbx
import helper as helper
import pulumi_databricks as databricks
import pulumi

# Create an Azure Resource Group
resource_group = resources.ResourceGroup('pulumi_databricks_resource_group')

# Create an Azure resource (Storage Account)
account = storage.StorageAccount('pulumidbxsa', location="uksouth",
                                 resource_group_name=resource_group.name,
                                 sku=storage.SkuArgs(
                                     name=storage.SkuName.STANDARD_LRS,
                                 ),
                                 kind=storage.Kind.STORAGE_V2)

# Export the primary key of the Storage Account
primary_key = pulumi.Output.all(resource_group.name, account.name) \
    .apply(lambda args: storage.list_storage_account_keys(
        resource_group_name=args[0],
        account_name=args[1]
    )).apply(lambda accountKeys: accountKeys.keys[0].value)

# create databricks workspace
workspace = dbx.Workspace("workspace",
                          location="westus",
                          managed_resource_group_id=f"/subscriptions/{helper.SUBSCRIPTION_ID}/resourceGroups/pulumi_databricks_managed_resource_group", # NOQA E501
                          parameters=dbx.WorkspaceCustomParametersArgs(
                              prepare_encryption=dbx.WorkspaceCustomBooleanParameterArgs( # NOQA E501
                                  value=True,
                              ),
                          ),
                          resource_group_name=resource_group.name,
                          workspace_name="pulumi_databricks_workspace")

# create databricks group
group = databricks.Group("py-group", display_name="DataGrillen")

# export key
pulumi.export("primary_storage_key", primary_key)
