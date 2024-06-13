output "id" {
  value       = azapi_resource.egn.id
  description = "The Event Grid namespace ID."
}
output "endpoint" {
  value       = azapi_resource.egn.endpoint
  description = "The Endpoint associated with the Event Grid Namespace."
}
output "primary_access_key" {
  value       = azapi_resource.egn.primary_access_key
  description = "The Primary Shared Access Key associated with the Event Grid Namespace."
}
output "secondary_access_key" {
  value       = azapi_resource.egn.secondary_access_key
  description = "The Secondary Shared Access Key associated with the Event Grid Namespace."
}
output "identity" {
  value       = azapi_resource.egn.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Namespace."
}
