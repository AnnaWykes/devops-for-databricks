# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.76.0"
    }
    # databricks = {
    #   source  = "databrickslabs/databricks"
    #   version = "0.3.7"
    #   # configuration_aliases = [ databricks.provider_adb ]
    # }
  }
}

# Configure the azurerm provider
provider "azurerm" {
  client_id         = var.client_id
  client_secret     = var.client_secret
  tenant_id         = var.tenant_id
  subscription_id   = var.subscription_id
  # client_id             = var.ARM_CLIENT_ID
  # client_secret         = var.ARM_CLIENT_SECRET
  # tenant_id             = var.ARM_TENANT_ID
  # subscription_id       = var.ARM_SUBSCRIPTION_ID
  features {}
}

#######################################################################################################################
#### Backend-Config
#######################################################################################################################

## Configure the AzureRM tfstate Name
terraform {
    backend "azurerm" {
        key                  = "terraform.tfstate"   # TO CHANGE: <app_name>.<evn>.terraform.tfstate & backend_config.tfvars 
        container_name       = "terraformstate"
        storage_account_name = "devops4dbxterraformstate"
        resource_group_name  = "devopsfordatabricks-terraform-state"
    }
}

## Import the remote state of the platform level items
data "terraform_remote_state" "platform" {
    backend = "azurerm"
    workspace = var.environment
    config = {
        key                  = "terraform.tfstate"   # TO CHANGE: <app_name>.<evn>.terraform.tfstate & backend_config.tfvars 
        container_name       = "terraformstate"
        storage_account_name = "devops4dbxterraformstate"
        resource_group_name  = "devopsfordatabricks-terraform-state"
    }
}
