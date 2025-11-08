resource "cloudflare_dns_record" "alias_test" {
  content  = "1.1.1.1"
  name     = "devop.ing"
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_devop_ing
  settings = {}
}
resource "cloudflare_dns_record" "OCI_ZRH_ARM_devop_ing_traefik" {
  content  = var.oci-zrh-arm-ip
  name     = "devop.ing"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_devop_ing
  settings = {}
}

resource "cloudflare_dns_record" "OCI_ZRH_ARM_devop_ing_wildcard_traefik" {
  content  = "devop.ing"
  name     = "*.devop.ing"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_devop_ing
  settings = {}
}