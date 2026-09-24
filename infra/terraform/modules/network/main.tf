resource "azurerm_virtual_network" "this" {
  name                = "vnet-aks-sandbox"
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = [
    "10.10.0.0/16"
  ]

  tags = {
    Environment = "Sandbox"
    ManagedBy   = "Terraform"
  }
}


resource "azurerm_subnet" "aks_node" {
  name                 = "aks-node-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [
    "10.10.1.0/24"
  ]
}


resource "azurerm_subnet" "aks_pod" {
  name                 = "aks-pod-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [
    "10.10.2.0/23"
  ]
}