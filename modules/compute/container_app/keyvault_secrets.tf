
data "azurerm_key_vault_secret" "secret" {
  for_each = { for s in try(var.settings.secret, {}) : s.key => s if try(s.keyvault, null) != null }
  name     = var.settings.secret.keyvault.secret_name
  key_vault_id = try(
    var.settings.secret.keyvault.id,
    var.combined_resources.keyvaults[try(var.settings.secret.keyvault.lz_key, var.client_config.landingzone_key)][var.settings.secret.keyvault.key].id,
  )
}