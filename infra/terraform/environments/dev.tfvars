dns_zone_name = "kannadi.net"

# Add all A records here
dns_a_records = {
  "@" = {
    ttl     = 300
    records = ["20.50.100.10"] # Can be your Public IP
  }
  "api" = {
    ttl     = 300
    records = ["20.50.100.10"]
  }
}

# Add all CNAME records here
dns_cname_records = {
  "www" = {
    ttl    = 300
    record = "kannadi.net"
  }
  "docs" = {
    ttl    = 300
    record = "kannadi.net"
  }
}

# Add all Whitelist, SPF, or Verification TXT records here
dns_txt_records = {
  "@" = {
    ttl   = 300
    value = "v=spf1 include:_spf.google.com ~all"
  }
  "_domainconnect" = {
    ttl   = 300
    value = "connect.domains.microsoft.com"
  }
  "_whitelist-token" = {
    ttl   = 300
    value = "custom-auth-token-12345"
  }
}