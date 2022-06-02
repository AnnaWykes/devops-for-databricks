#######################################################################################################################
#### Create Data Lake Containers
#######################################################################################################################
resource "azurerm_storage_container" "data_lake_storage_containers" {
  count                 = length(var.data_lake_storage_containers)
  name                  = var.data_lake_storage_containers[count.index].name
  storage_account_name  = azurerm_storage_account.data_lake_storage.name
  container_access_type = var.data_lake_storage_containers[count.index].access_type
  depends_on            = [azurerm_storage_account.data_lake_storage]
}