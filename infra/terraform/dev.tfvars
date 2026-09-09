resource_group_name = "1-02984b8e-playground-sandbox"

location = "South Central US"

aks_name = "aks-sandbox"

kubernetes_version = "1.34.0"

vnet_name = "vnet-aks-sandbox"

vnet_address_space = [
  "10.10.0.0/16"
]

node_subnet_name = "aks-node-subnet"

node_subnet_address_prefixes = [
  "10.10.1.0/24"
]

pod_subnet_name = "aks-pod-subnet"

pod_subnet_address_prefixes = [
  "10.10.2.0/23"
]