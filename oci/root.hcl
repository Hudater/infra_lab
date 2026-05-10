# Root Terragrunt Configuration
# This file contains shared configuration for all environments

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 8"
    }
  }
}

provider "oci" {
  region              = var.oci_region
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key         = var.private_key
}
EOF
}

# Common inputs for all environments
inputs = {
  ssh_authorized_keys = get_env("OCI_SSH_PUBLIC_KEY", "")
  
  # OCI Provider authentication
  tenancy_ocid = get_env("OCI_CLI_TENANCY", "")
  user_ocid    = get_env("OCI_CLI_USER", "")
  fingerprint  = get_env("OCI_CLI_FINGERPRINT", "")
  private_key  = get_env("OCI_CLI_KEY_CONTENT", "")
}
