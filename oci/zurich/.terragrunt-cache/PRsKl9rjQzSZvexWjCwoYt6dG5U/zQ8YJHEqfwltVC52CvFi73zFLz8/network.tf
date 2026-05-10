locals {
  vcn_name         = "${var.region_name}-vcn"
  subnet_name      = "${var.region_name}-subnet"
  dns_label_suffix = var.region_name
}

resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = [var.vcn_cidr]
  display_name   = local.vcn_name
  dns_label      = "vcn${local.dns_label_suffix}"

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "Internet Gateway ${local.vcn_name}"
  enabled        = true

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}

resource "oci_core_default_route_table" "default_rt" {
  manage_default_resource_id = oci_core_vcn.main.default_route_table_id
  display_name               = "Default Route Table for ${local.vcn_name}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_default_security_list" "default_sl" {
  manage_default_resource_id = oci_core_vcn.main.default_security_list_id
  display_name               = "Default Security List for ${local.vcn_name}"

  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
}

resource "oci_core_default_dhcp_options" "dhcp_opts" {
  manage_default_resource_id = oci_core_vcn.main.default_dhcp_options_id
  display_name               = "Default DHCP Options for ${local.vcn_name}"
  domain_name_type           = "CUSTOM_DOMAIN"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["${local.dns_label_suffix}.oraclevcn.com"]
  }
}

resource "oci_core_subnet" "main" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.main.id
  cidr_block                 = var.subnet_cidr
  display_name               = local.subnet_name
  dns_label                  = "subnet${local.dns_label_suffix}"
  prohibit_internet_ingress  = false
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_default_route_table.default_rt.id
  dhcp_options_id            = oci_core_default_dhcp_options.dhcp_opts.id
  security_list_ids          = [oci_core_default_security_list.default_sl.id]

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}
