resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "aks_node_subnet" {
  name                 = var.node_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name

  address_prefixes = var.node_subnet_address_prefixes
}

resource "azurerm_subnet" "aks_pod_subnet" {
  name                 = var.pod_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name

  address_prefixes = var.pod_subnet_address_prefixes
}