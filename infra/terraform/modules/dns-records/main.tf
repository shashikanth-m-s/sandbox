# A Records
resource "azurerm_dns_a_record" "this" {
  for_each            = var.a_records
  name                = each.key
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
}

# CNAME Records
resource "azurerm_dns_cname_record" "this" {
  for_each            = var.cname_records
  name                = each.key
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
}

# TXT Records (Whitelist verification, SPF, etc.)
resource "azurerm_dns_txt_record" "this" {
  for_each            = var.txt_records
  name                = each.key
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl

  record {
    value = each.value.value
  }
}