#######################################################################################################################
#### Databricks Provider
#######################################################################################################################
## Configure the Databricks Provider
terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.11"
      # configuration_aliases = [ databricks.provider_adb ]
    }
  }
}

provider "databricks" {
  host                = azurerm_databricks_workspace.databricks_workspace.workspace_url
  azure_client_id     = var.client_id
  azure_client_secret = var.client_secret
  azure_tenant_id     = var.tenant_id
}