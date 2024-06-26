output "id" {
  value       = azapi_resource.egn.id
  description = "The Event Grid namespace ID."
}
output "identity" {
  value       = azapi_resource.egn.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Namespace."
}

output "endpoint" {
  value       = jsondecode(azapi_resource.egn).properties.outputs.endpoint.value
  description = "The endpoint of the Event Grid Namespace."
}
