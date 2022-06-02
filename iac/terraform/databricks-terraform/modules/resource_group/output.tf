output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azure_region" {
  value = azurerm_resource_group.rg.location
}

output "tags" {
  value = azurerm_resource_group.rg.tags
}