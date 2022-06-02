#######################################################################################################################
#### Key Vault
#######################################################################################################################
resource "azurerm_key_vault" "key_vault" {
  resource_group_name             = var.resource_group_name  
  location                        = var.azure_region  
  name                            = var.vault_name
  tenant_id                       = var.tenant_id
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  lifecycle { 
    prevent_destroy   = true
    ignore_changes    = [access_policy]
  }

    tags = var.tags
}