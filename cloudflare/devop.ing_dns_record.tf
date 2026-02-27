resource "cloudflare_dns_record" "archive-docs" {
  content = "hudater.github.io"
  name    = "archive-docs.devop.ing"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_devop_ing
  settings = {
    flatten_cname = false
  }
}
