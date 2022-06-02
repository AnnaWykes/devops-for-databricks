data "azurerm_client_config" "current" {}

## Get Key Vault ID
data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}