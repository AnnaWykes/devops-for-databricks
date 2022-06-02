#===========================================================================================================#
# Description : Execute Terraform Infrastructure
# Author      : Falek Miah
# Created Date: 16/09/2019
#===========================================================================================================#

## Login and setup Azure
az login

## Check Subscriptions available
az account list --output table

## Set Subscription
az account set --subscription="[TODO]"

#############################################################################################################
Clear-Host

## Set location of tf-templates
Set-Location ""

terraform -version

#############################################################################################################
## View/Set Workspace which sets the environment variables
#############################################################################################################
## Execute Init when initially setting up
terraform workspace list
#terraform workspace new dev
terraform workspace select dev

#############################################################################################################
## Execute Dev environment
#############################################################################################################
## Terraform Init & Validate
# terraform init -upgrade ## Update provider
terraform init -backend-config="./backend_config/tf_state_config.hcl"
terraform validate

## Terraform Plan
terraform plan -var-file="./terraform.tfvars" -var-file="./backend_config/backend_config.tfvars"
# terraform plan -var-file="./terraform.tfvars" -out=tfplan.out
# terraform show -json tfplan.out > tfplan.json

## Terraform Apply
terraform apply -var-file="./terraform.tfvars" -var-file="./backend_config/backend_config.tfvars"
# terraform apply -var-file="./terraform.tfvars" -auto-approve

## Terraform Destroy
terraform destroy -var-file="./terraform.tfvars" -var-file="./backend_config/backend_config.tfvars"
# terraform destroy -var-file="./terraform.tfvars" -auto-approve

#############################################################################################################
## Update State File manually
#############################################################################################################

#terraform state rm 'azurerm_recovery_services_protected_vm.datalib-vault-1'
#terraform state rm 'azurerm_subnet.subnet_internal'
#terraform state rm 'azurerm_virtual_machine_data_disk_attachment.disk-vm-attachment'

#############################################################################################################
## Terraform log settings
#############################################################################################################
$env:TF_LOG_PATH="terraform-logs.txt"
# $env:TF_LOG="TRACE"
# $env:TF_LOG="DEBUG"
$env:TF_LOG="WARN"
$env:TF_LOG="ERROR"
