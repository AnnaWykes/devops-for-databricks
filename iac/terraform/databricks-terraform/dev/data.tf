## Get current config info
data "azurerm_client_config" "current" {}

## Get Key Vault ID
data "azurerm_key_vault" "key_vault" {
  name                = local.vault_name
  resource_group_name = local.resource_group_name
  depends_on          = [ module.resource_group, module.key_vault ]
}

## Get Blob Storage
data "azurerm_storage_account" "blob_storage" {
  name                = local.blob_storage_name
  resource_group_name = local.resource_group_name
  depends_on          = [ module.resource_group, module.blob_storage ]
}