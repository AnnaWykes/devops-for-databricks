#######################################################################################################################
#### Assign Role and Permissions
#######################################################################################################################
## Assign Current User/Service Principal "Contributor" role for Data Lake Storage
resource "azurerm_role_assignment" "current_spn_data_lake" {
  scope                = azurerm_storage_account.data_lake_storage.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [azurerm_storage_account.data_lake_storage]
}