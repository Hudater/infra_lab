terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      # version = "7.25.0"
      version = "~> 7"
    }
  }
}

provider "oci" {
  # Configuration options
}
