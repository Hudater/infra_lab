resource "cloudflare_dns_record" "OCI_BOM_ARM_domain_lab_traefik" {
  content  = var.oci-bom-arm-ip
  name     = var.domain_lab
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "OCI_BOM_ARM_wildcard_domain_lab_traefik" {
  content  = var.domain_lab
  name     = "*.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "authentik_domain_lab" {
  content  = var.domain_lab
  name     = "authentik.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "headscale_domain_lab" {
  comment  = "Headscale not proxied due to connection error"
  content  = var.domain_lab
  name     = "headscale.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "whoami_domain_lab" {
  content  = var.domain_lab
  name     = "whoami.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "OCI_BOM_AMD_1_domain_lab_netbird" {
  content  = var.oci-bom-amd-1-ip
  name     = "muamd.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}

resource "cloudflare_dns_record" "netbird_domain_lab" {
  comment  = "Netbird one liner install on OCI-BOM-AMD-1"
  content  = "muamd.${var.domain_lab}"
  name     = "netbird.${var.domain_lab}"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_domain_lab
  settings = {}
}
