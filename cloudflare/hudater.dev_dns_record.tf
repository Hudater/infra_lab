resource "cloudflare_dns_record" "hudater_dev_gh_pages_1" {
  content  = "185.199.108.153"
  name     = hudater.dev
  proxied  = true
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "hudater_dev_gh_pages_2" {
  content  = "185.199.109.153"
  name     = hudater.dev
  proxied  = true
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "hudater_dev_gh_pages_3" {
  content  = "185.199.110.153"
  name     = hudater.dev
  proxied  = true
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "hudater_dev_gh_pages_4" {
  content  = "185.199.111.153"
  name     = hudater.dev
  proxied  = true
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "www_hudater_dev" {
  content  = "hudater.github.io"
  name     = "www.hudater.dev"
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "blog_hudater_dev" {
  content  = "hudater.github.io"
  name     = "blog.hudater.dev"
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "docs_hudater_dev" {
  content = "hudater.github.io"
  name    = "docs.hudater.dev"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_hudater_dev
  settings = {
    flatten_cname = false
  }
}
resource "cloudflare_dns_record" "mail_return_hudater_dev" {
  content  = "return.smtp2go.net"
  name     = "em1369722.hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_link_hudater_dev" {
  content  = "track.smtp2go.net"
  name     = "link.hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_dkim_hudater_dev" {
  content  = "dkim.smtp2go.net"
  name     = "s1369722._domainkey.hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "CNAME"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_route_3_hudater_dev" {
  content  = "route3.mx.cloudflare.net"
  name     = "hudater.dev"
  priority = 49
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_route_2_hudater_dev" {
  content  = "route2.mx.cloudflare.net"
  name     = "hudater.dev"
  priority = 99
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_route_1_hudater_dev" {
  content  = "route1.mx.cloudflare.net"
  name     = "hudater.dev"
  priority = 96
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_dkim_txt_hudater_dev" {
  content  = "\"v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78k\" \"m4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB\""
  name     = "cf2024-1._domainkey.hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_dmarc_txt_hudater_dev" {
  comment  = "DMARC for mail"
  content  = "\"v=DMARC1;p=quarantine;rua=mailto:harshit@hudater.dev;ruf=mailto:harshit@hudater.dev;\""
  name     = "_dmarc.hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

resource "cloudflare_dns_record" "mail_spf_txt_hudater_dev" {
  content  = "\"v=spf1 include:_spf.mx.cloudflare.net ~all\""
  name     = "hudater.dev"
  proxied  = false
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_hudater_dev
  settings = {}
}

