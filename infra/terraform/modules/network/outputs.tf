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