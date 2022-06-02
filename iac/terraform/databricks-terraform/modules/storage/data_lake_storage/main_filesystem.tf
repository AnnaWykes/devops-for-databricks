#######################################################################################################################
#### Create Data Lake Filesystem
#######################################################################################################################
resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_storage_filesystem" {
  name               = var.data_lake_storage_filesystem_name
  storage_account_id = azurerm_storage_account.data_lake_storage.id
  depends_on         = [azurerm_storage_account.data_lake_storage]
}