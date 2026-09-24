output "a_record_fqdns" {
  value = { for k, v in azurerm_dns_a_record.this : k => v.fqdn }
}

output "cname_record_fqdns" {
  value = { for k, v in azurerm_dns_cname_record.this : k => v.fqdn }
}