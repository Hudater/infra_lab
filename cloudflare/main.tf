terraform {
  # cloud {
  #   hostname     = "app.terraform.io"
  #   organization = "homelab_hudater"
  #   workspaces {
  #     name = "Cloudflare"
  #   }
  # }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cf_edit_all_api_token
}
