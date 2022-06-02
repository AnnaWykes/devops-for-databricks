#######################################################################################################################
#### Blob Storage
#######################################################################################################################

output "blob_storage_name" {
  value = azurerm_storage_account.blob_storage.name
}

# output "blobcontainer_name" {
#   value = azurerm_storage_container.blobcontainer.name
# }