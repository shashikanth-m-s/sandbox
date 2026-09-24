output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.this.name
}

output "aks_node_subnet_id" {
  description = "AKS node subnet ID"
  value       = azurerm_subnet.aks_node.id
}

output "aks_pod_subnet_id" {
  description = "AKS pod subnet ID"
  value       = azurerm_subnet.aks_pod.id
}

output "public_ip_address" {
  description = "The allocated public IP address"
  value       = azurerm_public_ip.this.ip_address
}

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.this.id
}