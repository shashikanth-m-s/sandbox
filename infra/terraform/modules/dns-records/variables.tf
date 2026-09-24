variable "resource_group_name" {
  type        = string
  description = "Resource Group name where the DNS zone resides"
}

variable "zone_name" {
  type        = string
  description = "DNS zone name (e.g., kannadi.net)"
}

variable "a_records" {
  type = map(object({
    ttl     = number
    records = list(string)
  }))
  default     = {}
  description = "Map of A records to create"
}

variable "cname_records" {
  type = map(object({
    ttl    = number
    record = string
  }))
  default     = {}
  description = "Map of CNAME records to create"
}

variable "txt_records" {
  type = map(object({
    ttl   = number
    value = string
  }))
  default     = {}
  description = "Map of TXT records (e.g. SPF, domain whitelist/verification)"
}