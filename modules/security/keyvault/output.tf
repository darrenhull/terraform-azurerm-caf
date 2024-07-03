output "id" {
  value = azurerm_key_vault.keyvault.id
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}


output "name" {
  value = azurerm_key_vault.keyvault.name
}

output "rbac_id" {
  value = azurerm_key_vault.keyvault.id
}

output "base_tags" {
  value = local.tags
}

output "secret_ids" {
  description = "The IDs of all secrets"
  value = merge(
    { for s in azurerm_key_vault_secret.secret : s.name => s.id },
    { for s in azurerm_key_vault_secret.secret_ignore_changes : s.name => s.id }
  )
}
