locals {
  dns_zone_name = "${var.region_name}.oraclevcn.com"
}

resource "oci_dns_view" "vcn_view" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.region_name}-vcn-view"
}

resource "oci_dns_zone" "private_zone" {
  compartment_id = var.compartment_ocid
  name           = local.dns_zone_name
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  view_id        = oci_dns_view.vcn_view.id
  dnssec_state   = "DISABLED"

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}

resource "oci_dns_zone" "reverse_zone" {
  compartment_id = var.compartment_ocid
  name           = var.reverse_zone_name
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  view_id        = oci_dns_view.vcn_view.id
  dnssec_state   = "DISABLED"

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}

# Forward DNS Records
resource "oci_dns_rrset" "amd1_a_record" {
  zone_name_or_id = oci_dns_zone.private_zone.id
  domain          = "${var.region_name}-amd-1.${local.dns_zone_name}"
  rtype           = "A"

  items {
    domain = "${var.region_name}-amd-1.${local.dns_zone_name}"
    rdata  = oci_core_instance.amd1_instance.private_ip
    rtype  = "A"
    ttl    = 300
  }
}

resource "oci_dns_rrset" "amd2_a_record" {
  zone_name_or_id = oci_dns_zone.private_zone.id
  domain          = "${var.region_name}-amd-2.${local.dns_zone_name}"
  rtype           = "A"

  items {
    domain = "${var.region_name}-amd-2.${local.dns_zone_name}"
    rdata  = oci_core_instance.amd2_instance.private_ip
    rtype  = "A"
    ttl    = 300
  }
}

resource "oci_dns_rrset" "arm_a_record" {
  zone_name_or_id = oci_dns_zone.private_zone.id
  domain          = "${var.region_name}-arm.${local.dns_zone_name}"
  rtype           = "A"

  items {
    domain = "${var.region_name}-arm.${local.dns_zone_name}"
    rdata  = oci_core_instance.arm_instance.private_ip
    rtype  = "A"
    ttl    = 300
  }
}

# Reverse DNS Records
resource "oci_dns_rrset" "amd1_ptr_record" {
  zone_name_or_id = oci_dns_zone.reverse_zone.id
  domain          = "${join(".", reverse(split(".", oci_core_instance.amd1_instance.private_ip)))}.in-addr.arpa"
  rtype           = "PTR"

  items {
    domain = "${join(".", reverse(split(".", oci_core_instance.amd1_instance.private_ip)))}.in-addr.arpa"
    rdata  = "${var.region_name}-amd-1.${local.dns_zone_name}."
    rtype  = "PTR"
    ttl    = 300
  }
}

resource "oci_dns_rrset" "amd2_ptr_record" {
  zone_name_or_id = oci_dns_zone.reverse_zone.id
  domain          = "${join(".", reverse(split(".", oci_core_instance.amd2_instance.private_ip)))}.in-addr.arpa"
  rtype           = "PTR"

  items {
    domain = "${join(".", reverse(split(".", oci_core_instance.amd2_instance.private_ip)))}.in-addr.arpa"
    rdata  = "${var.region_name}-amd-2.${local.dns_zone_name}."
    rtype  = "PTR"
    ttl    = 300
  }
}

resource "oci_dns_rrset" "arm_ptr_record" {
  zone_name_or_id = oci_dns_zone.reverse_zone.id
  domain          = "${join(".", reverse(split(".", oci_core_instance.arm_instance.private_ip)))}.in-addr.arpa"
  rtype           = "PTR"

  items {
    domain = "${join(".", reverse(split(".", oci_core_instance.arm_instance.private_ip)))}.in-addr.arpa"
    rdata  = "${var.region_name}-arm.${local.dns_zone_name}."
    rtype  = "PTR"
    ttl    = 300
  }
}
