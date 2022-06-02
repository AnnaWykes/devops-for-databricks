locals {   
    #######################################################################################################################
    #### Azure Resource
    #######################################################################################################################
    resource_group_name = join("", ["rg",var.app_name, var.azure_short_region, var.environment])

    # service_principal_name = join("-", [var.app_name, "spn-01", var.azure_short_region, var.environment])

    #######################################################################################################################
    #### Resource Tags
    #######################################################################################################################
    tags = {
        source          = var.source_name  
        environment     = var.environment
        location        = var.azure_region
        project         = var.project
        app             = var.app_name
        app_tag         = var.app_tag
        contact         = var.contact
        contact_details = var.contact_details
        description     = var.description         
    }

    #######################################################################################################################
    #### Key Vault
    #######################################################################################################################

    vault_name = join("", [var.app_name, "kv01", var.environment])

    #######################################################################################################################
    #### Databricks
    #######################################################################################################################

    databricks_name                        = join("-", [var.app_name, "dbx-01", var.azure_short_region, var.environment])
    databricks_managed_resource_group_name = join("-", ["rg", var.app_name, "dbx-managed-01", var.azure_short_region, var.environment]) 
    databricks_secret_scope_name           = join("-", [var.app_name, "dbx-scope-01"])
    databricks_token_name                  = join("-", [var.app_name, "dbx-token"])
    databricks_cluster_name                = join("-", [var.app_name, "dbx-cluster-01"])

    #######################################################################################################################
    #### Data Lake & Blob Storage
    #######################################################################################################################

    blob_storage_name                 = join("", [var.app_name, "blob", var.azure_short_region, var.environment])
    data_lake_storage_name            = join("", [var.app_name, "adls", var.azure_short_region, var.environment])   
    data_lake_storage_filesystem_name = join("", [var.app_name, "adlsfs", var.azure_short_region, var.environment])

}
