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
#### Blob Storage
#######################################################################################################################

variable "blob_storage_name" {
    description = "Name for blob storage"
}

variable "blob_storage_account_tier" {
  description = "Defines the Account Tier to use for this blob storage account, valid options are Standard and Premium."
  default     = "Standard"
}

variable "blob_storage_account_replication_type" {
  description = "Defines the type of Replication to use for this blob storage account, valid options are LRS, GRS, RAGRS and ZRS."
  default     = "LRS"
}

variable "blob_storage_access_tier" {
  description = "Defines the Access Tier for BlobStorage and StorageV2 accounts, valid options are Hot and Cool."
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
#### Key Vault
#######################################################################################################################
variable "key_vault_name" {
    description = "Key Vault Name"
}