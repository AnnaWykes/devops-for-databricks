#######################################################################################################################
#### Create Blob Containers
#######################################################################################################################

resource "azurerm_storage_container" "blob_storage_containers" {
  count                 = length(var.blob_storage_containers)
  name                  = var.blob_storage_containers[count.index].name
  storage_account_name  = azurerm_storage_account.blob_storage.name
  container_access_type = var.blob_storage_containers[count.index].access_type
  depends_on            = [azurerm_storage_account.blob_storage]
}