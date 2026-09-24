output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "aks_node_subnet_id" {
  value = module.network.aks_node_subnet_id
}

output "aks_pod_subnet_id" {
  value = module.network.aks_pod_subnet_id
}

output "aks_name" {
  value = module.aks.name
}

output "aks_id" {
  value = module.aks.id
}