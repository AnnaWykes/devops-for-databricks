#######################################################################################################################
#### Blob Storage
#######################################################################################################################

resource "azurerm_storage_account" "blob_storage" {
  resource_group_name       = var.resource_group_name
  location                  = var.azure_region
  name                      = var.blob_storage_name
  tags                      = var.tags

  account_kind              = "StorageV2"
  account_tier              = var.blob_storage_account_tier
  account_replication_type  = var.blob_storage_account_replication_type
  access_tier               = var.blob_storage_access_tier
  enable_https_traffic_only = "true"
  is_hns_enabled            = "true"

  lifecycle { 
        prevent_destroy     = true
    }

}

#######################################################################################################################
#### Add Blob Storage Configs to Key Vault Secrets
#######################################################################################################################

## Add Key Vault Secret: Blob Storage Account Name
resource "azurerm_key_vault_secret" "kv_blob_storage_account_name" {
  name         = "blob-storage-account-name"
  value        = azurerm_storage_account.blob_storage.name
  key_vault_id = data.azurerm_key_vault.key_vault.id
  content_type = join(" - ", ["Blob Storage Account Name", azurerm_storage_account.blob_storage.name])
  depends_on   = [azurerm_storage_account.blob_storage]
}