#######################################################################################################################
#### Databricks
#######################################################################################################################

output "databricks_name" {
  value = azurerm_databricks_workspace.databricks_workspace.name
}

output "databricks_managed_resource_group_name" {
  value = azurerm_databricks_workspace.databricks_workspace.managed_resource_group_name
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.databricks_workspace.workspace_url}/"
}

output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.databricks_workspace.id
}

output "databricks_secret_scope_name" {
  value = databricks_secret_scope.databricks_secret_scope.name
}

output "databricks_token_name" {
  value = databricks_secret.sec_databricks_token.key
}

output "databricks_token_value" {
  value = databricks_secret.sec_databricks_token.string_value
  sensitive = true
}

output "databricks_cluster_name" {
  value = databricks_cluster.databricks_cluster.cluster_name
}

output "databricks_cluster_id" {
  value = databricks_cluster.databricks_cluster.id
}