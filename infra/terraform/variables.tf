variable "resource_group_name" {
  description = "Existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "South Central US"
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "aks-sandbox"
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
  default     = "vnet-aks-sandbox"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

variable "node_subnet_name" {
  type    = string
  default = "aks-node-subnet"
}

variable "node_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.10.1.0/24"]
}

variable "pod_subnet_name" {
  type    = string
  default = "aks-pod-subnet"
}

variable "pod_subnet_address_prefixes" {
  type    = list(string)
  default = ["10.10.2.0/23"]
}