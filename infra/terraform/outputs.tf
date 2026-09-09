output "vnet_id" {
  value = azurerm_virtual_network.aks_vnet.id
}

output "node_subnet_id" {
  value = azurerm_subnet.aks_node_subnet.id
}

output "pod_subnet_id" {
  value = azurerm_subnet.aks_pod_subnet.id
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks.kubernetes_version
}