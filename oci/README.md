# OCI Infrastructure

Multi-region Oracle Cloud Infrastructure managed with Terragrunt.

## Overview

Each region runs identical infrastructure:

- **2x AMD VMs**
- **1x ARM VM**
- **VCN + Subnet** with private DNS
- **Network Security Groups** per instance

## Structure

```txt
oci/
├── _modules/           # Shared Terraform code
│   ├── compute.tf
│   ├── network.tf
│   ├── dns.tf
│   └── ...
│
├── zurich/             # Zurich region
│   └── terragrunt.hcl  # Region-specific config
│
├── bombay/             # Bombay region (disabled)
│   └── terragrunt.hcl
│
└── root.hcl            # Shared Terragrunt config
```

## Deployment

**Via GitHub Actions** (recommended):

1. Push changes to `main`
2. Review plan in PR/commit
3. Comment `/apply zurich` to deploy

**Local**:

```bash
cd oci/zurich
terragrunt plan
terragrunt apply
```

## Adding a New Region

### 1. Create Region Config

```bash
mkdir oci/singapore
```

Create `oci/singapore/terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "homelab_hudater"
    
    workspaces {
      name = "OCI-singapore"
    }
  }
}
EOF
}

terraform {
  source = "../_modules"
}

inputs = {
  oci_region          = "ap-singapore-1"
  region_name         = "sin"
  vcn_cidr            = "10.70.0.0/16"
  subnet_cidr         = "10.70.0.0/24"
  amd1_private_ip     = "10.70.0.242"
  amd2_private_ip     = "10.70.0.243"
  arm_private_ip      = "10.70.0.154"
  reverse_zone_name   = "70.10.in-addr.arpa"
  availability_domain = get_env("OCI_SINGAPORE_AD", "")
  alert_email         = get_env("OCI_ALERT_EMAIL", "")
  budget_amount       = "1"
  compartment_ocid    = get_env("OCI_SINGAPORE_COMPARTMENT_OCID", "")
  amd_image_ocid      = get_env("OCI_SINGAPORE_AMD_IMAGE_OCID", "")
  arm_image_ocid      = get_env("OCI_SINGAPORE_ARM_IMAGE_OCID", "")
}
```

### 2. Create HCP Workspace

Go to app.terraform.io and create workspace:

- Name: `OCI-singapore`
- Execution Mode: **Local**

### 3. Add GitHub Secrets

Add these secrets to your repository:

```env
OCI_SINGAPORE_USER
OCI_SINGAPORE_FINGERPRINT
OCI_SINGAPORE_TENANCY
OCI_SINGAPORE_KEY_CONTENT
OCI_SINGAPORE_AD
OCI_SINGAPORE_COMPARTMENT_OCID
OCI_SINGAPORE_AMD_IMAGE_OCID
OCI_SINGAPORE_ARM_IMAGE_OCID
```

### 4. Create Workflow

Copy `oci-zurich.yml` to `oci-singapore.yml` and update:

- Workflow name
- Paths to `oci/singapore/**`
- All `ZURICH` → `SINGAPORE`
- Region to `ap-singapore-1`

### 5. Deploy

```bash
git add oci/singapore/
git commit -m "Add Singapore region"
git push
# Comment: /apply singapore
```
