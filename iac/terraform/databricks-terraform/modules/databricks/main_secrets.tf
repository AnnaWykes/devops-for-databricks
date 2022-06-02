#######################################################################################################################
#### Databricks Secrets
#######################################################################################################################
## Create databricks_secret_scope
resource "databricks_secret_scope" "databricks_secret_scope" {
  name                     = var.databricks_secret_scope_name
  initial_manage_principal = "users"
  depends_on               = [ azurerm_databricks_workspace.databricks_workspace ]
}

## Create databricks_token
resource "databricks_token" "pat" {
  comment          = "Created from ${abspath(path.module)}"
  # lifetime_seconds = 86400 // 1 day token
  lifetime_seconds = 8640000 // 100 day token
  depends_on       = [ databricks_secret_scope.databricks_secret_scope ]
}

## Create databricks_secret - databricks_token
resource "databricks_secret" "sec_databricks_token" {
  key          = var.databricks_token_name
  string_value = databricks_token.pat.token_value
  scope        = databricks_secret_scope.databricks_secret_scope.name
  depends_on   = [ databricks_secret_scope.databricks_secret_scope, databricks_token.pat ]
}

## Create databricks_secret - spn_client_secret_key
resource "databricks_secret" "sec_spn_client_secret_key" {
  key          = "spn-client-secret-key"
  string_value = var.client_secret
  scope        = databricks_secret_scope.databricks_secret_scope.name
  depends_on   = [ databricks_secret_scope.databricks_secret_scope ]
}

## Create databricks_secret - blob_storage_key
resource "databricks_secret" "sec_blob_storage_key" {
  key          = "blob_storage_key"
  string_value = var.blob_storage_access_key
  scope        = databricks_secret_scope.databricks_secret_scope.name
  depends_on   = [ databricks_secret_scope.databricks_secret_scope ]
}

#######################################################################################################################
#### Add to Key Vault
#######################################################################################################################
## Add Key Vault Secret: Databricks Token
resource "azurerm_key_vault_secret" "kv_databricks_token" {
  name         = "dbx-token"
  value        = databricks_token.pat.token_value
  key_vault_id = var.key_vault_id
  content_type = "Databricks Access Token"
  depends_on   = [ databricks_token.pat ]
}