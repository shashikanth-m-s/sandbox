output "name" {
  description = "Resource Group name"
  value       = data.azurerm_resource_group.this.name
}

output "id" {
  description = "Resource Group ID"
  value       = data.azurerm_resource_group.this.id
}

output "location" {
  description = "Resource Group location"
  value       = data.azurerm_resource_group.this.location
}