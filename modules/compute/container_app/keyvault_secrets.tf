data "azurerm_key_vault_secret" "secret" {
  for_each = try(var.settings.keyvault_secret, null) != null ? toset(["enabled"]) : toset([])
  name     = var.settings.keyvault_secret.secret_name
  key_vault_id = try(
    var.settings.keyvault_secret.key_vault_id,
    var.keyvaults[try(var.settings.keyvault_secret.lz_key, var.client_config.landingzone_key)][var.settings.keyvault_secret.keyvault_key].id,
  )
}