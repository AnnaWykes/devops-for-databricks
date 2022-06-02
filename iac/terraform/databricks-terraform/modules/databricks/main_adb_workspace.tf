#######################################################################################################################
#### Databricks Workspace
#######################################################################################################################
## Configure AzureRM Databricks Workspace
resource "azurerm_databricks_workspace" "databricks_workspace" {
  location                    = var.azure_region
  name                        = var.databricks_name
  resource_group_name         = var.resource_group_name
  managed_resource_group_name = var.databricks_managed_resource_group_name
  sku                         = var.databricks_sku_name

  ## TODO - Vnet Inject
  # custom_parameters {
  #   no_public_ip        = false
  #   private_subnet_name = var.private_subnet_name
  #   public_subnet_name  = var.public_subnet_name
  #   virtual_network_id  = var.vnet_id
  # }
}
