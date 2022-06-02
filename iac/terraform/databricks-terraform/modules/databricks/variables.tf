#######################################################################################################################
#### Azure Resource
#######################################################################################################################

variable "client_id" {
  description = "Azure Service Principal (SPN) Application (client) ID found in App Registrations"
  type = string
}

variable "client_secret" {
  description = "Azure Service Principal (SPN) Application (client) Password"
  type = string
}

variable "tenant_id" {
  description = "Tenant ID/Directory ID found in Active Directory"
}

variable "subscription_id" {
  description = "The subscription id taken from the environment variable"
}

variable "azure_region" {
    description = "Azure region the resource is located, this is the full region name e.g. West Europe."
}

variable "resource_group_name" {
  description = "Resource Group Name for Tokenization in Release Pipeline"
}

#######################################################################################################################
#### Resource Tags
#######################################################################################################################

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
variable "key_vault_id" {
    description = "Key Vault ID"
}

#######################################################################################################################
#### Databricks
#######################################################################################################################

variable "databricks_name" {
    description = "Default name for Databricks"
}

variable "databricks_managed_resource_group_name" {
    description = "Databricks managed resource group name"
}

variable "databricks_secret_scope_name" {
    description = "Secret Scope name for Databricks"
}

variable "databricks_token_name" {
    description = "Token name for Databricks"
}

variable "databricks_cluster_name" {
    description = "Default cluster name for Databricks"
}

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

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

variable "data_lake_storage_name" {
    description = "Name for data lake storage"
}

variable "blob_storage_name" {
    description = "Name for blob storage"
}

variable "blob_storage_access_key" {
    description = "Primary access key for blob storage"
}