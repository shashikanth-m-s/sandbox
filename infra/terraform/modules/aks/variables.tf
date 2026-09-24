variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_subnet_id" {
  description = "AKS node subnet ID"
  type        = string
}

variable "pod_subnet_id" {
  description = "AKS pod subnet ID"
  type        = string
}