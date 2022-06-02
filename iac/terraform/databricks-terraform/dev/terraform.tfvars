#######################################################################################################################
#### Azure Resource
#######################################################################################################################

azure_region        = "UK South"
azure_short_region  = "uks"

#######################################################################################################################
#### Resource Tags
#######################################################################################################################

source_name     = "terraform"
environment     = "dev"                                ## CHANGE
project         = "DevOps for Databricks"              ## CHANGE
app_name        = "devopsfordbx"                ## CHANGE: No longer than 11 characters
app_tag         = "dev"                                ## CHANGE: First 3 characters of the app name
contact         = "Anna Wykes"                         ## CHANGE
contact_details = ""                                   ## CHANGE
description     = "Azure infrastructure"               ## CHANGE

#######################################################################################################################
#### Blob Storage
#######################################################################################################################

blob_storage_account_tier              = "Standard"
blob_storage_account_replication_type  = "LRS"
blob_storage_access_tier               = "Cool"

blob_storage_containers = [
    {
        name = "root"
        access_type = "private"
    },
    {
        name = "archived"
        access_type = "private"
    }
]

databricks_mount_blob_container_name = "root"

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

data_lake_storage_account_tier              = "Standard"
data_lake_storage_account_replication_type  = "LRS"
data_lake_storage_access_tier               = "Cool"

data_lake_storage_containers = [
    {
        name = "root"
        access_type = "private"
    }
]

databricks_mount_adls_container_name = "root"

#######################################################################################################################
#### Databricks
#######################################################################################################################

databricks_sku_name                = "standard"
databricks_spark_version           = "9.1.x-scala2.12"
databricks_node_type_id            = "Standard_DS3_v2"

databricks_autotermination_minutes = "10"
databricks_min_workers             = "1"
databricks_max_workers             = "4"

client_id = "[todo]"
client_secret =  "[todo]"
subscription_id = "[todo]"
tenant_id = "[todo]"
tf_state_backend_container_name = "terraformstate"
tf_state_backend_key_name = "terraform.tfstate"
tf_state_backend_resource_group_name = "devopsfordatabricks-terraform-state"
tf_state_backend_storage_account_name = "devops4dbxterraformstate"

