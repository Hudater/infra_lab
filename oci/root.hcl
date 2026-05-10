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
  region = var.oci_region
}
EOF
}

# Common inputs for all environments
inputs = {
  ssh_authorized_keys = get_env("OCI_SSH_PUBLIC_KEY", "")
}
