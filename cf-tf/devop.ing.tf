resource "cloudflare_dns_record" "alias_test" {
  content  = "1.1.1.1"
  name     = "devop.in"
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_devop_ing
  settings = {}
}
