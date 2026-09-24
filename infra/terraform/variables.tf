variable "resource_group_name" {
  description = "Existing Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "South Central US"
}


# ------------------------------------------------------------
# NETWORK
# ------------------------------------------------------------

variable "vnet_name" {
  description = "AKS VNet name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "node_subnet_name" {
  description = "AKS node subnet name"
  type        = string
}

variable "node_subnet_address_prefixes" {
  description = "AKS node subnet address prefixes"
  type        = list(string)
}

variable "pod_subnet_name" {
  description = "AKS pod subnet name"
  type        = string
}

variable "pod_subnet_address_prefixes" {
  description = "AKS pod subnet address prefixes"
  type        = list(string)
}


# ------------------------------------------------------------
# AKS
# ------------------------------------------------------------

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
}