#######################################################################################################################
#### Assign Role and Permissions
#######################################################################################################################

## Assign Current User/Service Principal Permissions to Key Vault Access Policy 
resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = var.tenant_id
  object_id               = data.azurerm_client_config.current.object_id
  key_permissions         = [ "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Purge"]
  secret_permissions      = [ "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  certificate_permissions = [ "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Purge"]
  depends_on              = [ azurerm_key_vault.key_vault ]
}