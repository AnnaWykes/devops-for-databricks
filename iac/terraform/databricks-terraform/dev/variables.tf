#######################################################################################################################
#### Terraform State
#######################################################################################################################

variable "tf_state_backend_key_name" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

variable "tf_state_backend_container_name" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

variable "tf_state_backend_storage_account_name" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

variable "tf_state_backend_resource_group_name" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

#######################################################################################################################
#### Azure Resource
#######################################################################################################################

variable "client_id" {
  description = "Service Principal (SPN) Application (client) ID found in App Registrations"
  type = string
}

variable "client_secret" {
  description = "Service Principal (SPN) Application (client) Password"
  type = string
}

variable "tenant_id" {
  description = "Tenant ID/Directory ID found in Active Directory"
}

variable "subscription_id" {
  description = "The subscription id taken from the environment variable"
}

variable "azure_short_region" {
    description = "Define the short name for the region e.g. weu."
}

variable "azure_region" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

# variable "resource_group_name" {
#   description = "Resource Group Name for Tokenization in Release Pipeline"
# }

#######################################################################################################################
#### Resource Tags
#######################################################################################################################

variable "source_name" {
  description = "source of details"
}

variable "environment" {
  description = "Enter the name of the environment"
}

variable "project" {
  description = "Enter the name of the project"
}

variable "app_name" {
  description = "Enter the name of the app name (lower case characters only)"
}

variable "app_tag" {
  description = "Enter first 3 characters of the app name (lower case characters only)"
}

variable "contact" {
  description = "Contact name for the application"
}

variable "contact_details" {
  description = "Contact informations details"
}

variable "description" {
  description = "A description for the application"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "terraform"
  }
}

#######################################################################################################################
#### Key Vault
#######################################################################################################################


#######################################################################################################################
#### Blob Storage
#######################################################################################################################

variable "blob_storage_account_tier" {
  description = "Defines the Account Tier to use for this blob storage account, valid options are Standard and Premium."
  default     = "Standard"
}

variable "blob_storage_account_replication_type" {
  description = "Defines the type of Replication to use for this blob storage account, valid options are LRS, GRS, RAGRS and ZRS."
  default     = "LRS"
}

variable "blob_storage_access_tier" {
  description = "Defines the Access Tier for Blob_storage and StorageV2 accounts, valid options are Hot and Cool."
  #default     = "Cool"
}

variable "blob_storage_containers" {
  description = "List of containers to create and their access levels."
  type = list(object({
    name        = string
    access_type = string
  }))
  default = []
}

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

variable "data_lake_storage_account_tier" {
  description = "Defines the Account Tier to use for this data lake storage account, valid options are Standard and Premium."
  default     = "Standard"
}

variable "data_lake_storage_account_replication_type" {
  description = "Defines the type of Replication to use for this data lake storage account, valid options are LRS, GRS, RAGRS and ZRS."
  default     = "LRS"
}

variable "data_lake_storage_access_tier" {
  description = "Defines the Access Tier for BlobStorage and StorageV2 accounts, valid options are Hot and Cool."
  #default     = "Cool"
}

variable "data_lake_storage_containers" {
  description = "List of containers to create and their access levels."
  type = list(object({
    name        = string
    access_type = string
  }))
  default = []
}

#######################################################################################################################
#### Databricks
#######################################################################################################################

# variable "databricks_name" {
#     description = "Default name for Databricks"
# }

# variable "databricks_managed_resource_group_name" {
#     description = "Dabaricks managed resource group name"
# }

# variable "databricks_secret_scope_name" {
#     description = "Secret Scope name for Databricks"
# }

# variable "databricks_token_name" {
#     description = "Token name for Databricks"
# }

# variable "databricks_cluster_name" {
#     description = "Default cluster name for Databricks"
# }

variable "databricks_sku_name" {
    description = "Databricks tier"
}

variable "databricks_spark_version" {
  description = "Spark Runtime Version for databricks clusters"
}

variable "databricks_node_type_id" {
  description = "Type of worker nodes for databricks clusters"
}

variable "databricks_autotermination_minutes" {
    description = "Auto Termination in minutes for databricks clusters"
}

variable "databricks_min_workers" {
  description = "Minimum workers in a cluster"
}

variable "databricks_max_workers" {
  description = "Maximum workers in a cluster"
}

# variable "databricks_mount_name" {
#   description = "Mount name for Databricks"
# }

variable "databricks_mount_adls_container_name" {
  description = "Data lake storage container to mount"
}

variable "databricks_mount_blob_container_name" {
  description = "Name of blob containers to mount"
}
