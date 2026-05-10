include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Generate backend for Zurich
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "homelab_hudater"
    
    workspaces {
      name = "OCI-zurich"
    }
  }
}
EOF
}

# Point to the shared module
terraform {
  source = "../_modules"
}

# Zurich-specific inputs
inputs = {
  # Region configuration
  oci_region      = "eu-zurich-1"
  region_name     = "zrh"
  
  # Network configuration
  vcn_cidr    = "10.80.0.0/16"
  subnet_cidr = "10.80.0.0/24"
  
  # Instance private IPs
  amd1_private_ip = "10.80.0.242"
  amd2_private_ip = "10.80.0.243"
  arm_private_ip  = "10.80.0.154"
  
  # DNS configuration
  reverse_zone_name = "80.10.in-addr.arpa"
  availability_domain = get_env("OCI_ZURICH_AD", "")
  
  # Budget configuration
  alert_email   = get_env("OCI_ALERT_EMAIL", "")
  budget_amount = "1"
  
  # Sensitive values from environment (region-specific)
  compartment_ocid = get_env("OCI_ZURICH_COMPARTMENT_OCID", "")
  amd_image_ocid   = get_env("OCI_ZURICH_AMD_IMAGE_OCID", "")
  arm_image_ocid   = get_env("OCI_ZURICH_ARM_IMAGE_OCID", "")
}
