#######################################################################################################################
#### Databricks Mount Storage
#######################################################################################################################
## Mount Data Lake storage to Cluster 
resource "databricks_azure_adls_gen2_mount" "databricks_mount_adls" {
    mount_name             = join("-", ["lake", var.databricks_mount_adls_container_name])
    cluster_id             = databricks_cluster.databricks_cluster.id

    container_name         = var.databricks_mount_adls_container_name
    storage_account_name   = var.data_lake_storage_name

    tenant_id              = data.azurerm_client_config.current.tenant_id
    client_id              = data.azurerm_client_config.current.client_id
    client_secret_scope    = databricks_secret_scope.databricks_secret_scope.name
    client_secret_key      = databricks_secret.sec_spn_client_secret_key.key
    initialize_file_system = true

    depends_on             = [ databricks_secret_scope.databricks_secret_scope, databricks_secret.sec_spn_client_secret_key ]
}

## Mount Blob Storage to Cluster 
resource "databricks_azure_blob_mount" "databricks_mount_blob" {
    mount_name           = join("-", ["blob", var.databricks_mount_blob_container_name])
    cluster_id           = databricks_cluster.databricks_cluster.id

    container_name       = var.databricks_mount_blob_container_name
    storage_account_name = var.blob_storage_name
    
    auth_type            = "ACCESS_KEY"
    token_secret_scope   = databricks_secret_scope.databricks_secret_scope.name
    token_secret_key     = databricks_secret.sec_blob_storage_key.key

    depends_on           = [ databricks_secret_scope.databricks_secret_scope, databricks_secret.sec_blob_storage_key ]
}