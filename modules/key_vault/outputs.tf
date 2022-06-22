output "key_vault_id" {
  description = "Value of the Key Vault ID"
  value = azurerm_key_vault.this.id
}

output "key_vault_uri" {
    description = "Value of the Key Vault URI"
    value = azurerm_key_vault.this.vault_uri
}

output "name" {
  description = "Value of the Key Vault name"
  value = azurerm_key_vault.this.name
}