resource "cloudflare_email_routing_address" "gmail_mail_address_haops_dev" {
  account_id = var.cf_account_id
  email      = var.mail_gmail_dest
}

resource "cloudflare_email_routing_rule" "rule_literal_cf_email_routing_haops_dev" {
  enabled  = true
  name     = "Forward to my gmail destination address"
  priority = 0
  zone_id  = var.zone_id_haops_dev
  actions = [{
    type  = "forward"
    value = [var.mail_gmail_dest]
  }]
  matchers = [{
    field = "to"
    type  = "literal"
    value = var.mail_admin_haops
  }]
}

resource "cloudflare_email_routing_catch_all" "rule_all_cf_email_routing_haops_dev" {
  enabled = true
  zone_id = var.zone_id_haops_dev
  name    = "Catch all rule for Haops.dev"
  actions = [{
    type  = "forward"
    value = [var.mail_gmail_dest]
  }]
  matchers = [{
    type = "all"
  }]
}
