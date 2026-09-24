resource "azurerm_kubernetes_cluster" "this" {

  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = var.aks_name

  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name                = "system"
    node_count          = 1
    vm_size             = "Standard_B2s"

    vnet_subnet_id      = var.node_subnet_id
    pod_subnet_id       = var.pod_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"

    service_cidr      = "10.20.0.0/16"
    dns_service_ip    = "10.20.0.10"

    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Sandbox"
    ManagedBy   = "Terraform"
  }
}