############################################################
# Existing Resource Group
############################################################

module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = var.resource_group_name
}


############################################################
# Network
############################################################

module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.name
  location            = var.location
}


############################################################
# AKS
############################################################

module "aks" {
  source = "./modules/aks"

  resource_group_name = module.resource_group.name
  location            = var.location

  aks_name            = var.aks_name
  kubernetes_version  = var.kubernetes_version

  node_subnet_id      = module.network.aks_node_subnet_id
  pod_subnet_id       = module.network.aks_pod_subnet_id
}


############################################################
# Future Modules
############################################################

# module "nsg" {
#   source = "./modules/nsg"
# }

# module "acr" {
#   source = "./modules/acr"
# }

# module "key_vault" {
#   source = "./modules/key-vault"
# }

# module "storage" {
#   source = "./modules/storage"
# }

# module "service_bus" {
#   source = "./modules/service-bus"
# }

# module "postgres" {
#   source = "./modules/postgres"
# }

# module "private_dns" {
#   source = "./modules/private-dns"
# }

# module "private_endpoint" {
#   source = "./modules/private-endpoint"
# }

# module "application_gateway" {
#   source = "./modules/application-gateway"
# }

# module "bastion" {
#   source = "./modules/bastion"
# }

# module "monitoring" {
#   source = "./modules/monitoring"
# }