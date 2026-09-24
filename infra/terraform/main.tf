############################################################
# Existing Resource Group
############################################################

module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}


############################################################
# Network
############################################################

module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

############################################################
# AKS
############################################################

module "aks" {
  source = "./modules/aks"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  aks_name           = var.aks_name
  kubernetes_version = var.kubernetes_version

  node_subnet_id = module.network.aks_node_subnet_id
  pod_subnet_id  = module.network.aks_pod_subnet_id
}

############################################################
# Public DNS Zone
############################################################

module "public_dns" {
  source              = "./modules/public-dns"
  dns_zone_name       = var.dns_zone_name
  resource_group_name = module.resource_group.name

  tags = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

############################################################
# DNS Records
############################################################

module "dns_records" {
  source              = "./modules/dns-records"
  resource_group_name = module.resource_group.name
  zone_name           = module.public_dns.dns_zone_name

  a_records     = var.dns_a_records
  cname_records = var.dns_cname_records
  txt_records   = var.dns_txt_records
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