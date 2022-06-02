#######################################################################################################################
#### Add Configs to Key Vault Secrets
#######################################################################################################################
## Add Key Vault Secret: ARM-SUBSCRIPTION-ID
resource "azurerm_key_vault_secret" "kv_arm_subscription_id" {
  name         = "ARM-SUBSCRIPTION-ID"
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = azurerm_key_vault.key_vault.id
  content_type = "ARM Subscription ID"
  depends_on   = [ azurerm_key_vault.key_vault, azurerm_key_vault_access_policy.current_user ]
}

## Add Key Vault Secret: ARM-TENANT-ID
resource "azurerm_key_vault_secret" "kv_arm_tenant_id" {
  name         = "ARM-TENANT-ID"
  value        = var.tenant_id
  key_vault_id = azurerm_key_vault.key_vault.id
  content_type = "ARM Tenant ID/ Directory ID"
  depends_on   = [ azurerm_key_vault.key_vault, azurerm_key_vault_access_policy.current_user ]
}