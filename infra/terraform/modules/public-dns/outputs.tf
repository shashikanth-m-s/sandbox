output "dns_zone_name" {
  description = "The name of the public DNS zone."
  value       = azurerm_dns_zone.this.name
}

output "dns_zone_id" {
  description = "The resource ID of the public DNS zone."
  value       = azurerm_dns_zone.this.id
}

output "name_servers" {
  description = "The Azure name servers assigned to this public DNS zone."
  value       = azurerm_dns_zone.this.name_servers
}