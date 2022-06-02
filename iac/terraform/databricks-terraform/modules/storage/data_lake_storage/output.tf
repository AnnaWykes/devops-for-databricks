#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

output "data_lake_storage_name" {
  value = azurerm_storage_account.data_lake_storage.name
}

# output "datalakecontainer_name" {
#   value = azurerm_storage_container.data_lake_storage_containers.name
# }

output "data_lake_storage_filesystem_name" {
  value = azurerm_storage_data_lake_gen2_filesystem.data_lake_storage_filesystem.name
}

output "data_lake_storage_filesystem_id" {
  value = azurerm_storage_data_lake_gen2_filesystem.data_lake_storage_filesystem.id
}