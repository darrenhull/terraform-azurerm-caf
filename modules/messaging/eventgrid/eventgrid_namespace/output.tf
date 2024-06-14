output "id" {
  value       = azapi_resource.egn.id
  description = "The Event Grid namespace ID."
}
output "identity" {
  value       = azapi_resource.egn.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Namespace."
}
