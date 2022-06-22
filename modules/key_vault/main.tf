# ---------------------------------------------------------------------------------------------------------------------
# Azure Resource Group Creation or selection - Default is "false"
# ---------------------------------------------------------------------------------------------------------------------
data "azurerm_resource_group" "this" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_key_vault" "this" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku_name                 = var.sku_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  
  tags                     = var.tags

}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Key Vault Access Policy
# ---------------------------------------------------------------------------------------------------------------------
# Will be created based on the value of the "create_current_user_access_policy" variable

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "this" {
  count = var.create_current_user_access_policy ? 1 : 0

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
  ]

  storage_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_secret" "this" {
  name          = var.storage_account_access_key_name
  value         = var.storage_account_access_key
  key_vault_id  = azurerm_key_vault.this.id
}