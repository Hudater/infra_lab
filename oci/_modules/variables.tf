variable "oci_region" {
  description = "OCI Region"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID"
  type        = string
  sensitive   = true
}

variable "amd_image_ocid" {
  description = "Image OCID for AMD instances in the region"
  type        = string
  sensitive   = true
}

variable "arm_image_ocid" {
  description = "Image OCID for ARM instance in the region"
  type        = string
  sensitive   = true
}

variable "availability_domain" {
  description = "Availability Domain for the region"
  type        = string
}

variable "alert_email" {
  description = "Email for budget alerts"
  type        = string
}

variable "budget_amount" {
  description = "Monthly budget amount in USD"
  type        = string
  default     = "1"
}

variable "region_name" {
  description = "Human-readable region name (e.g., zrh, bom, sin, etc.)"
  type        = string
  validation {
    condition     = length(var.region_name) >= 3 && length(var.region_name) <= 5
    error_message = "Region name must be between 3 and 5 characters (e.g., zrh, bom, sin)."
  }
}

variable "vcn_cidr" {
  description = "VCN CIDR block (e.g., 10.80.0.0/16 for zrh, 10.60.0.0/16 for bom)"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR block (e.g., 10.80.0.0/24 for zrh, 10.60.0.0/24 for bom)"
  type        = string
}

variable "amd1_private_ip" {
  description = "Private IP for AMD-1 instance (within subnet CIDR)"
  type        = string
}

variable "amd2_private_ip" {
  description = "Private IP for AMD-2 instance (within subnet CIDR)"
  type        = string
}

variable "arm_private_ip" {
  description = "Private IP for ARM instance (within subnet CIDR)"
  type        = string
}

variable "reverse_zone_name" {
  description = "Reverse DNS zone name (e.g., 50.10.in-addr.arpa for zrh, 60.10.in-addr.arpa for bom)"
  type        = string
}

variable "ssh_authorized_keys" {
  description = "SSH public key for OCI instances"
  type        = string
}

# OCI Provider Authentication
variable "tenancy_ocid" {
  description = "OCI Tenancy OCID for authentication"
  type        = string
  sensitive   = true
}

variable "user_ocid" {
  description = "OCI User OCID for authentication"
  type        = string
  sensitive   = true
}

variable "fingerprint" {
  description = "Fingerprint of the OCI API key"
  type        = string
  sensitive   = true
}

variable "private_key" {
  description = "Private key content for OCI API authentication"
  type        = string
  sensitive   = true
}
