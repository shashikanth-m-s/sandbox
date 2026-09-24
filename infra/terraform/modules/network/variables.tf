variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP"
  type        = string
  default     = "pip-sandbox-dev"
}