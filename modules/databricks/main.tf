# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Databricks workspace
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_databricks_workspace" "this" {
  name                                  = var.databricks_workspace_name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  sku                                   = var.sku

  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Databricks Cluster
# ---------------------------------------------------------------------------------------------------------------------

data "databricks_node_type" "smallest" {
  depends_on = [azurerm_databricks_workspace.this]
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  depends_on        = [azurerm_databricks_workspace.this]
  long_term_support = true
}

resource "databricks_cluster" "main" {
  cluster_name            = var.cluster_name
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = var.cluster_autotermination_minutes
  autoscale {
    min_workers = var.cluster_min_workers
    max_workers = var.cluster_max_workers
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Access policy to Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "databricks_secret_scope" "kv" {
  depends_on = [
    azurerm_databricks_workspace.this,
    databricks_cluster.main
  ]
  name = var.databricks_secret_scope_name

  keyvault_metadata {
    resource_id = var.key_vault_id
    dns_name    = var.key_vault_uri
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Databricks SQL Endpoint
# ---------------------------------------------------------------------------------------------------------------------

resource "databricks_sql_endpoint" "this" {
  name              = var.sql_endpoint_name
  cluster_size      = var.sql_endpoint_cluster_size
  auto_stop_mins    = var.sql_endpoint_cluster_auto_stop_mins
  min_num_clusters  = var.sql_endpoint_cluster_autoscale_min_workers
  max_num_clusters  = var.sql_endpoint_cluster_autoscale_max_workers
}

# ---------------------------------------------------------------------------------------------------------------------
# Setup Data Access for Databricks SQL
# ---------------------------------------------------------------------------------------------------------------------
resource "databricks_sql_global_config" "this" {
  data_access_config = {
    "spark.hadoop.fs.azure.account.key.${var.storage_account_name}.dfs.core.windows.net" : "{{secrets/${var.databricks_secret_scope_name}/${var.storage_account_access_key_name}}}"
  }
}