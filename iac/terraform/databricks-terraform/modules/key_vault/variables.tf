#######################################################################################################################
#### Azure Resource
#######################################################################################################################

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
#### Key Valut
#######################################################################################################################

variable "vault_name" {
    description = "Key Vault Name"
}