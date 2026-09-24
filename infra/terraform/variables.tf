variable "resource_group_name" {
  description = "Existing Azure Resource Group name"
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
  description = "AKS Kubernetes version"
  type        = string
}

variable "dns_zone_name" {
  description = "Public domain name (e.g., mydomain.com)"
  type        = string
}

variable "dns_a_records" {
  description = "Map of A records"
  type = map(object({
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "dns_cname_records" {
  description = "Map of CNAME records"
  type = map(object({
    ttl    = number
    record = string
  }))
  default = {}
}

variable "dns_txt_records" {
  description = "Map of TXT records (whitelist, verification, SPF, etc.)"
  type = map(object({
    ttl   = number
    value = string
  }))
  default = {}
}