resource "cloudflare_dns_record" "OCI_BOM_ARM_hudater_xyz_traefik" {
  content  = var.oci-bom-arm-ip
  name     = "hudater.xyz"
  proxied  = true
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "OCI_BOM_ARM_wildcard_hudater_xyz_traefik" {
  content  = "hudater.xyz"
  name     = "*.hudater.xyz"
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "authentik_hudater_xyz" {
  content  = "hudater.xyz"
  name     = "authentik.hudater.xyz"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "headscale_hudater_xyz" {
  comment  = "Headscale not proxied due to connection error"
  content  = "hudater.xyz"
  name     = "headscale.hudater.xyz"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "whoami_hudater_xyz" {
  content  = "hudater.xyz"
  name     = "whoami.hudater.xyz"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "OCI_BOM_AMD_1_hudater_xyz_netbird" {
  content  = var.oci-bom-amd-1-ip
  name     = "muamd.hudater.xyz"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}

resource "cloudflare_dns_record" "netbird_hudater_xyz" {
  comment  = "Netbird one liner install on OCI-BOM-AMD-1"
  content  = "muamd.hudater.xyz"
  name     = "netbird.hudater.xyz"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_xyz
  settings = {}
}
