output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "azure_region" {
  value = module.resource_group.azure_region
}

#######################################################################################################################
#### Key Vault
#######################################################################################################################

output "key_vault_name" {
  value = module.key_vault.vault_name
}

#######################################################################################################################
#### Blob Storage
#######################################################################################################################

output "blob_storage_name" {
  value = module.blob_storage.blob_storage_name
}

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################

output "data_lake_storage_name" {
  value = module.data_lake_storage.data_lake_storage_name
}

output "data_lake_storage_filesystem_name" {
  value = module.data_lake_storage.data_lake_storage_filesystem_name
}

#######################################################################################################################
#### Databricks
#######################################################################################################################

output "databricks_name" {
  value = module.databricks.databricks_name
}

output "databricks_managed_resource_group_name" {
  value = module.databricks.databricks_managed_resource_group_name
}

output "databricks_host" {
  value = module.databricks.databricks_host
}

output "databricks_secret_scope_name" {
  value = module.databricks.databricks_secret_scope_name
}

output "databricks_token_name" {
  value = module.databricks.databricks_token_name
}

output "databricks_cluster_name" {
  value = module.databricks.databricks_cluster_name
}
