
resource "azapi_resource" "egn" {
  type = "Microsoft.EventGrid/namespaces@2023-12-15-preview"
 #todo: name needs to come from a naming module.
  name      = join("-", ["egn",var.settings.name])
  location  = var.location
  parent_id = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].id
  tags      = local.tags

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  body = jsonencode({

    properties = {
      isZoneRedundant     = try(var.settings.is_zone_redundant,null)
      publicNetworkAccess = try(var.settings.public_network_access, "Enabled")
    }

    sku = {
      capacity = var.settings.sku_count
      name     = var.settings.sku_name
    }
  })

  response_export_values = ["properties.endpoint"]
}
