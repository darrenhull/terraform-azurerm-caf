module "private_endpoint" {
  source   = "../../../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azapi_resource.egn.id
  name                = each.value.name
  location            = var.location
  resource_group_name = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  settings            = each.value
  global_settings     = var.global_settings
  tags                = local.tags
  base_tags           = var.global_settings.inherit_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
