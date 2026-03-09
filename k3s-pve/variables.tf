variable "proxmox_endpoint" {
  description = "Proxmox API URL e.g. https://192.168.1.10:8006"
  type        = string
}

variable "proxmox_api_token" {
  description = "API token: 'user@pam!token-id=secret' — create in PVE UI → Datacenter → API Tokens"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS verify for self-signed cert"
  type        = bool
  default     = true
}

variable "proxmox_ssh_user" {
  description = "SSH user for Proxmox host (bpg provider uses SSH for some operations)"
  type        = string
  default     = "root"
}

variable "proxmox_node" {
  type    = string
  default = "pve"
}

variable "template_vmid" {
  description = "VMID of the Ubuntu 22.04 cloud-init template to clone from"
  type        = number
  default     = 9000
}

variable "storage_pool" {
  description = "Proxmox storage pool for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vlan_id" {
  description = "VLAN tag for k3s node NICs"
  type        = number
  default     = 200
}

variable "server_count" {
  type    = number
  default = 3
}

variable "agent_count" {
  type    = number
  default = 3
}

variable "server_vmid_start" {
  type    = number
  default = 200
}

variable "agent_vmid_start" {
  type    = number
  default = 210
}

variable "node_cidr" {
  type    = string
  default = "192.168.10.0/24"
}

variable "node_prefix" {
  type    = number
  default = 24
}

variable "server_ip_start" {
  description = "Host octet for first server (e.g. 10 → 192.168.10.10)"
  type        = number
  default     = 10
}

variable "agent_ip_start" {
  description = "Host octet for first agent (e.g. 20 → 192.168.10.20)"
  type        = number
  default     = 20
}

variable "gateway" {
  type    = string
  default = "192.168.10.1"
}

variable "dns_server" {
  description = "Point to your Pi-hole LXC"
  type        = string
  default     = "192.168.10.5"
}

variable "server_cores" {
  type    = number
  default = 2
}

variable "server_memory" {
  description = "MB"
  type        = number
  default     = 4096
}

variable "server_disk_size" {
  type    = number
  default = 20
}

variable "agent_cores" {
  type    = number
  default = 2
}

variable "agent_memory" {
  description = "MB"
  type        = number
  default     = 4096
}

variable "agent_disk_size" {
  type    = number
  default = 30
}

variable "vm_user" {
  type    = string
  default = "ubuntu"
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}
