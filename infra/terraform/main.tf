module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  location             = var.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  node_subnet_name             = var.node_subnet_name
  node_subnet_address_prefixes = var.node_subnet_address_prefixes

  pod_subnet_name             = var.pod_subnet_name
  pod_subnet_address_prefixes = var.pod_subnet_address_prefixes
}


module "aks" {
  source = "./modules/aks"

  resource_group_name = var.resource_group_name
  location             = var.location

  aks_name            = var.aks_name
  kubernetes_version  = var.kubernetes_version

  node_subnet_id = module.network.node_subnet_id
  pod_subnet_id  = module.network.pod_subnet_id
}
