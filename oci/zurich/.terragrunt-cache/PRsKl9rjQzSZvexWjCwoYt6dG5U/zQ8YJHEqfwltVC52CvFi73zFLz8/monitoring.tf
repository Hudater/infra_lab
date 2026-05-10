# resource "oci_budget_budget" "monthly_budget" {
#   amount                                = var.budget_amount
#   compartment_id                        = var.compartment_ocid
#   display_name                          = "Budget-${var.region_name}-${var.budget_amount}EUR"
#   description                           = "${var.budget_amount} EUR Monthly Budget for ${var.region_name} region"
#   processing_period_type                = "MONTH"
#   reset_period                          = "MONTHLY"
#   target_type                           = "COMPARTMENT"
#   targets                               = [var.compartment_ocid]
#   budget_processing_period_start_offset = 1
# }

# resource "oci_budget_alert_rule" "budget_alert" {
#   budget_id      = oci_budget_budget.monthly_budget.id
#   type           = "ACTUAL"
#   threshold      = var.budget_amount
#   threshold_type = "ABSOLUTE"
#   recipients     = var.alert_email
# }
