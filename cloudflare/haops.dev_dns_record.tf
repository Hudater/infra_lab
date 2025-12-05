resource "cloudflare_dns_record" "docs" {
  content = "hudater.github.io"
  name    = "archive-docs.haops.dev"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_haops_dev
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "return_smtpgo" {
  content = "return.smtp2go.net"
  name    = "em1369722.haops.dev"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_haops_dev
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "track_smtpgo" {
  content = "track.smtp2go.net"
  name    = "link.haops.dev"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_haops_dev
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "dkim_smtpgo" {
  content = "dkim.smtp2go.net"
  name    = "s1369722._domainkey.haops.dev"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = var.zone_id_haops_dev
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "route3_mx_cf_email_routing" {
  content  = "route3.mx.cloudflare.net"
  name     = "haops.dev"
  priority = 83
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}

resource "cloudflare_dns_record" "route2_mx_cf_email_routing" {
  content  = "route2.mx.cloudflare.net"
  name     = "haops.dev"
  priority = 52
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}

resource "cloudflare_dns_record" "route1_mx_cf_email_routing" {
  content  = "route1.mx.cloudflare.net"
  name     = "haops.dev"
  priority = 99
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}

resource "cloudflare_dns_record" "dkim_txt_cf_email_routing" {
  content  = "\"v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78k\" \"m4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB\""
  name     = "cf2024-1._domainkey.haops.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}

resource "cloudflare_dns_record" "dmarc_mail" {
  comment  = "DMARC for mail"
  content  = "\"v=DMARC1;p=quarantine;rua=mailto:admin@haops.dev;ruf=mailto:admin@haops.dev;\""
  name     = "_dmarc.haops.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}

resource "cloudflare_dns_record" "spf_email" {
  content  = "\"v=spf1 include:_spf.mx.cloudflare.net ~all\""
  name     = "haops.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = var.zone_id_haops_dev
  settings = {}
}
