#######################################################################################################################
#### Azure Resource
#######################################################################################################################

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
variable "key_vault_name" {
    description = "Key Vault Name"
}

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

variable "data_lake_storage_name" {
    description = "Name for data lake storage"
}

variable "data_lake_storage_filesystem_name" {
    description = "Name for data lake file system"
}

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
