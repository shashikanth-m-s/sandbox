resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kubernetes_version = var.kubernetes_version

  dns_prefix = var.aks_name

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_B2s"

    vnet_subnet_id = azurerm_subnet.aks_node_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"

    # Azure CNI Pod Subnet
    pod_subnet_id = azurerm_subnet.aks_pod_subnet.id

    service_cidr   = "10.20.0.0/16"
    dns_service_ip = "10.20.0.10"

    network_policy = "azure"
  }

  tags = {
    Environment = "Dev"
    Purpose     = "AKS-Networking-Lab"
  }
}