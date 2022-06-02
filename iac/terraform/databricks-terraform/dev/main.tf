#######################################################################################################################
#### Azure Resource
#######################################################################################################################
module "resource_group" {
  source = "../modules/resource_group" 

  resource_group_name = local.resource_group_name
  azure_region        = var.azure_region 

  tags                = local.tags  
}

#######################################################################################################################
#### Key Vault
#######################################################################################################################
## Enter the variable name that is used in the module then the value
module "key_vault" {
  source              = "../modules/key_vault"

  resource_group_name = module.resource_group.resource_group_name
  azure_region        = module.resource_group.azure_region

  vault_name          = local.vault_name
  tenant_id           = var.tenant_id
  subscription_id     = var.subscription_id

  tags                = local.tags
  depends_on          = [ module.resource_group ]
}

#######################################################################################################################
#### Blob Storage
#######################################################################################################################
## Enter the variable name that is used in the module then the value
module "blob_storage" {
  source = "../modules/storage/blob_storage"

  resource_group_name                   = module.resource_group.resource_group_name
  azure_region                          = module.resource_group.azure_region
  
  blob_storage_name                     = local.blob_storage_name
  blob_storage_account_tier             = var.blob_storage_account_tier
  blob_storage_account_replication_type = var.blob_storage_account_replication_type
  blob_storage_access_tier              = var.blob_storage_access_tier
  blob_storage_containers               = var.blob_storage_containers

  key_vault_name                        = module.key_vault.vault_name
  tags                                  = local.tags
  depends_on                            = [ module.resource_group, module.key_vault ]
}

#######################################################################################################################
#### Data Lake Storage
#######################################################################################################################
## Enter the variable name that is used in the module then the value
module "data_lake_storage" {
  source = "../modules/storage/data_lake_storage"

  resource_group_name                         = module.resource_group.resource_group_name
  azure_region                                = module.resource_group.azure_region
  
  data_lake_storage_name                      = local.data_lake_storage_name
  data_lake_storage_account_tier              = var.data_lake_storage_account_tier
  data_lake_storage_account_replication_type  = var.data_lake_storage_account_replication_type
  data_lake_storage_access_tier               = var.data_lake_storage_access_tier
  data_lake_storage_containers                = var.data_lake_storage_containers
  data_lake_storage_filesystem_name           = local.data_lake_storage_filesystem_name

  key_vault_name                              = module.key_vault.vault_name
  tags                                        = local.tags
  depends_on                                  = [ module.resource_group, module.key_vault ]
}

#######################################################################################################################
#### Databricks
#######################################################################################################################
## Enter the variable name that is used in the module then the value
module "databricks" {
  source = "../modules/databricks" 

  client_id                              = var.client_id
  client_secret                          = var.client_secret
  tenant_id                              = var.tenant_id
  subscription_id                        = var.subscription_id

  resource_group_name                    = module.resource_group.resource_group_name
  azure_region                           = module.resource_group.azure_region

  databricks_name                        = local.databricks_name
  databricks_managed_resource_group_name = local.databricks_managed_resource_group_name
  databricks_sku_name                    = var.databricks_sku_name

  databricks_secret_scope_name           = local.databricks_secret_scope_name
  databricks_token_name                  = local.databricks_token_name

  databricks_cluster_name                = local.databricks_cluster_name
  databricks_spark_version               = var.databricks_spark_version
  databricks_node_type_id                = var.databricks_node_type_id
  databricks_autotermination_minutes     = var.databricks_autotermination_minutes
  databricks_min_workers                 = var.databricks_min_workers
  databricks_max_workers                 = var.databricks_max_workers

  data_lake_storage_name                 = module.data_lake_storage.data_lake_storage_name
  databricks_mount_adls_container_name   = var.databricks_mount_adls_container_name
  blob_storage_name                      = data.azurerm_storage_account.blob_storage.name
  blob_storage_access_key                = data.azurerm_storage_account.blob_storage.primary_access_key
  databricks_mount_blob_container_name   = var.databricks_mount_blob_container_name

  ## TODO - Vnet Inject
  # vnet_id             = "vnet"
  # private_subnet_name = "databricks-private-subnet"
  # public_subnet_name  = "databricks-public-subnet"
  
  key_vault_id                           = data.azurerm_key_vault.key_vault.id
  tags                                   = local.tags
}
