#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################
resource "azurerm_storage_account" "data_lake_storage" {
  resource_group_name       = var.resource_group_name
  location                  = var.azure_region
  name                      = var.data_lake_storage_name  
  tags                      = var.tags

  account_kind              = "StorageV2"
  account_tier              = var.data_lake_storage_account_tier
  account_replication_type  = var.data_lake_storage_account_replication_type
  access_tier               = var.data_lake_storage_access_tier
  enable_https_traffic_only = "true"
  is_hns_enabled            = "true"

  lifecycle { 
        prevent_destroy     = true
    }

}

#######################################################################################################################
#### Add Data Lake Configs to Key Vault Secrets
#######################################################################################################################
## Add Key Vault Secret: Data Lake Name
resource "azurerm_key_vault_secret" "kv_data_lake_storage_account_name" {
  name         = "data-lake-storage-account-name"
  value        = azurerm_storage_account.data_lake_storage.name
  key_vault_id = data.azurerm_key_vault.key_vault.id
  content_type = join(" - ", ["Data Lake Storage Account Name", azurerm_storage_account.data_lake_storage.name])
  depends_on   = [azurerm_storage_account.data_lake_storage]
}