resource "azapi_resource" "egnt" {
  type      = "Microsoft.EventGrid/namespaces/topics@2023-12-15-preview"
  name      = join("-", ["egn",var.settings.name])
  parent_id = can(var.settings.eventgrid_namespace.id) ? var.settings.eventgrid_namespace.id : var.remote_objects.eventgrid_namespaces[try(var.settings.eventgrid_namespace.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_namespace.key].id
  tags      = local.tags


  body = jsonencode({
    properties = {
      eventRetentionInDays = var.settings.event_retention_days
      inputSchema          = "CloudEventSchemaV1_0"
      publisherType        = "Custom"
    }
  })

  resource "azapi_resource" "event_grid_subscription" {
  type      = "Microsoft.EventGrid/namespaces/topics/eventSubscriptions@2023-12-15-preview"
  name      = var.name
  parent_id = can(var.settings.eventgrid_namespace_topic.id) ? var.settings.eventgrid_namespace_topic.id : var.remote_objects.eventgrid_namespace_topics[try(var.settings.eventgrid_namespace_topic.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_namespace_topic.key].id

  body = jsonencode({
    properties = {
      deliveryConfiguration = {
        deliveryMode = "Queue"
        queue = {
          eventTimeToLive              = var.settings.event_time_to_live
          maxDeliveryCount             = var.settings.max_delivery_count
          receiveLockDurationInSeconds = var.settings.lock_duration_seconds
        }
      }
      eventDeliverySchema = "CloudEventSchemaV1_0"
    }
  })
}