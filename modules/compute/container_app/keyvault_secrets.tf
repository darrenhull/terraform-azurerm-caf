
data "azurerm_key_vault_secret" "secret" {
  for_each = {
    for key, value in try(var.settings.secret, {}) : key => value
    if try(value.keyvault, null) != null
  }
  name     = each.value.keyvault.secret_name
  key_vault_id = try(
    each.value.keyvault.id,
    var.combined_resources.keyvaults[try(each.value.keyvault.lz_key, var.client_config.landingzone_key)][each.value.keyvault.key].id,
  )
}