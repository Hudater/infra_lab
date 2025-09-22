resource "cloudflare_dns_record" "OCI_BOM_ARM_274001_xyz" {
  comment  = "OCI Mumbai server on ARM"
  content  = var.oci-bom-arm-ip
  name     = "oci-bom-arm.274001.xyz"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_274001_xyz
  settings = {}
}

resource "cloudflare_dns_record" "OCI_BOM_AMD_1_274001_xyz" {
  comment  = "OCI Mumbai server 1 on x86_amd"
  content  = var.oci-bom-amd-1-ip
  name     = "oci-bom-amd-1.274001.xyz"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_274001_xyz
  settings = {}
}

resource "cloudflare_dns_record" "OCI_ZRH_ARM_274001_xyz" {
  comment  = "OCI Zurich server on ARM"
  content  = var.oci-zrh-arm-ip
  name     = "oci-zrh-arm.274001.xyz"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_274001_xyz
  settings = {}
}

resource "cloudflare_dns_record" "OCI_ZRH_AMD_1_274001_xyz" {
  comment  = "OCI Zurich server 1 on x86_amd"
  content  = var.oci-zrh-amd-1-ip
  name     = "oci-zrh-amd-1.274001.xyz"
  proxied  = false
  ttl      = 1
  type     = "A"
  zone_id  = var.zone_id_274001_xyz
  settings = {}
}
