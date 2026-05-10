locals {
  amd1_hostname = "${var.region_name}-amd-1"
  amd2_hostname = "${var.region_name}-amd-2"
  arm_hostname  = "${var.region_name}-arm"
}

data "oci_core_private_ips" "amd1" {
  ip_address = var.amd1_private_ip
  subnet_id  = oci_core_subnet.main.id
  depends_on = [oci_core_instance.amd1_instance]
}

data "oci_core_private_ips" "arm" {
  ip_address = var.arm_private_ip
  subnet_id  = oci_core_subnet.main.id
  depends_on = [oci_core_instance.arm_instance]
}

# Reserved Public IPs
resource "oci_core_public_ip" "amd1_public_ip" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.region_name}-amd-1-public-ip"
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.amd1.private_ips[0].id

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}

resource "oci_core_public_ip" "arm_public_ip" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.region_name}-arm-public-ip"
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.arm.private_ips[0].id

  defined_tags = {
    "Oracle-Tags.CreatedBy" = "terraform"
    "Oracle-Tags.CreatedOn" = timestamp()
  }
}
