resource "cloudflare_email_routing_address" "gmail_mail_address_hudater_dev" {
  account_id = var.cf_account_id
  email      = var.mail_gmail_dest
}

resource "cloudflare_email_routing_rule" "rule_literal_cf_email_routing_hudater_dev" {
  enabled  = true
  name     = "Rule created at 2025-06-22T20:46:39.758Z"
  priority = 0
  zone_id  = var.zone_id_hudater_dev
  actions = [{
    type  = "forward"
    value = [var.mail_gmail_dest]
  }]
  matchers = [{
    field = "to"
    type  = "literal"
    value = var.mail_harshit_hudater
  }]
}

resource "cloudflare_email_routing_catch_all" "rule_all_cf_email_routing_hudater_dev" {
  enabled = true
  zone_id = var.zone_id_hudater_dev
  name    = "Catch all rule for Hudater.dev"
  actions = [{
    type  = "forward"
    value = [var.mail_gmail_dest]
  }]
  matchers = [{
    type = "all"
  }]
}
