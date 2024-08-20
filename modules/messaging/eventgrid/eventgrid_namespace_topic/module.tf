resource "azapi_resource" "egnt" {
  type      = "Microsoft.EventGrid/namespaces/topics@2023-12-15-preview"
  name      = join("-", ["egnt",var.settings.name])
  parent_id = can(var.settings.eventgrid_namespace.id) ? var.settings.eventgrid_namespace.id : var.remote_objects.eventgrid_namespaces[try(var.settings.eventgrid_namespace.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_namespace.key].id

  body = jsonencode({
    properties = {
      eventRetentionInDays = var.settings.event_retention_days
      inputSchema          = "CloudEventSchemaV1_0"
      publisherType        = "Custom"
    }
  })

}