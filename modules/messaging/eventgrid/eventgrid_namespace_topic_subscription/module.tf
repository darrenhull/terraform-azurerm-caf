 resource "azapi_resource" "egnts" {
  type      = "Microsoft.EventGrid/namespaces/topics/eventSubscriptions@2023-12-15-preview"
  name      = join("-", ["egnts",var.settings.name])
  parent_id = can(var.settings.eventgrid_namespace_topic.id) ? var.settings.eventgrid_namespace_topic.id : var.remote_objects.eventgrid_namespace_topics[try(var.settings.eventgrid_namespace_topic.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_namespace_topic.key].id

  body = jsonencode({
    properties = {
      deliveryConfiguration = {
        deliveryMode = "Queue"
        queue = {
          eventTimeToLive              = var.settings.event_time_to_live
          maxDeliveryCount             = var.settings.max_delivery_count
          receiveLockDurationInSeconds = var.settings.receive_lock_duration_in_seconds
        }
      }
      eventDeliverySchema = "CloudEventSchemaV1_0"
    }
  })
 }