variable "dns_zone_name" {
  description = "The name of the public DNS zone (e.g., example.com)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the DNS zone will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the DNS zone"
  type        = map(string)
  default     = {}
}