module "eventgrid_namespace" {
  source   = "./modules/messaging/eventgrid/eventgrid_namespace"
  for_each = local.messaging.eventgrid_namespaces

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = {
    resource_groups = local.combined_objects_resource_groups
    vnets          = local.combined_objects_networking
    private_dns    = local.combined_objects_private_dns
  }
}
output "eventgrid_namespace" {
  value = module.eventgrid_namespace
}
