output "region_info" {
  description = "Region information"
  value = {
    region_name = var.region_name
    region_code = var.oci_region
  }
}

output "amd1_instance" {
  description = "AMD-1 instance details"
  value = {
    name        = oci_core_instance.amd1_instance.display_name
    private_ip  = oci_core_instance.amd1_instance.private_ip
    public_ip   = oci_core_public_ip.amd1_public_ip.ip_address
    shape       = oci_core_instance.amd1_instance.shape
    vcpus       = oci_core_instance.amd1_instance.shape_config[0].ocpus
    memory_gb   = oci_core_instance.amd1_instance.shape_config[0].memory_in_gbs
    boot_volume = oci_core_instance.amd1_instance.source_details[0].boot_volume_size_in_gbs
  }
}

output "amd2_instance" {
  description = "AMD-2 instance details"
  value = {
    name        = oci_core_instance.amd2_instance.display_name
    private_ip  = oci_core_instance.amd2_instance.private_ip
    shape       = oci_core_instance.amd2_instance.shape
    vcpus       = oci_core_instance.amd2_instance.shape_config[0].ocpus
    memory_gb   = oci_core_instance.amd2_instance.shape_config[0].memory_in_gbs
    boot_volume = oci_core_instance.amd2_instance.source_details[0].boot_volume_size_in_gbs
  }
}

output "arm_instance" {
  description = "ARM instance details"
  value = {
    name        = oci_core_instance.arm_instance.display_name
    private_ip  = oci_core_instance.arm_instance.private_ip
    public_ip   = oci_core_public_ip.arm_public_ip.ip_address
    shape       = oci_core_instance.arm_instance.shape
    vcpus       = oci_core_instance.arm_instance.shape_config[0].ocpus
    memory_gb   = oci_core_instance.arm_instance.shape_config[0].memory_in_gbs
    boot_volume = oci_core_instance.arm_instance.source_details[0].boot_volume_size_in_gbs
  }
}

output "network_info" {
  description = "Network information"
  value = {
    vcn_cidr    = oci_core_vcn.main.cidr_blocks[0]
    subnet_cidr = oci_core_subnet.main.cidr_block
    vcn_name    = oci_core_vcn.main.display_name
    subnet_name = oci_core_subnet.main.display_name
  }
}

output "connectivity_info" {
  description = "Complete instance connectivity information"
  value = {
    amd1 = {
      name       = oci_core_instance.amd1_instance.display_name
      private_ip = oci_core_instance.amd1_instance.private_ip
      public_ip  = oci_core_public_ip.amd1_public_ip.ip_address
      ssh        = "ssh ubuntu@${oci_core_public_ip.amd1_public_ip.ip_address}"
    }
    arm = {
      name       = oci_core_instance.arm_instance.display_name
      private_ip = oci_core_instance.arm_instance.private_ip
      public_ip  = oci_core_public_ip.arm_public_ip.ip_address
      ssh        = "ssh ubuntu@${oci_core_public_ip.arm_public_ip.ip_address}"
    }
  }
}
