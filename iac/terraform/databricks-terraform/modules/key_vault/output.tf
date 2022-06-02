#######################################################################################################################
#### Key Vault
#######################################################################################################################
# Output all content of module
output "key_vault" {
  value = azurerm_key_vault.key_vault
}

output "vault_name" {
  value = azurerm_key_vault.key_vault.name
}

# output "vault_id" {
#   value = azurerm_key_vault.key_vault.id
# }

# output "key_vault_id" {
#   value = azurerm_key_vault.key_vault.id
# }
