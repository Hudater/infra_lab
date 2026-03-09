terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.61"
    }
  }
  required_version = ">= 1.3.0"

  # backend "remote" {
  #   organization = "your-org"
  #   workspaces { name = "k3s-cluster" }
  # }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure

  ssh {
    agent    = true
    username = var.proxmox_ssh_user
  }
}

# ── Cloud-init snippet (uploaded once, shared by all VMs) ──────────────────
resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node

  source_raw {
    file_name = "k3s-user-data.yaml"
    data      = <<-EOF
      #cloud-config
      users:
        - name: ${var.vm_user}
          groups: sudo
          shell: /bin/bash
          sudo: ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            - ${var.ssh_public_key}
      package_update: true
      packages:
        - qemu-guest-agent
        - curl
        - ca-certificates
        - nfs-common
        - open-iscsi
      runcmd:
        - systemctl enable --now qemu-guest-agent
    EOF
  }
}

# ── Local maps ─────────────────────────────────────────────────────────────
locals {
  servers = {
    for i in range(var.server_count) :
    "k3s-server-${i + 1}" => {
      vmid = var.server_vmid_start + i
      ip   = cidrhost(var.node_cidr, var.server_ip_start + i)
    }
  }

  agents = {
    for i in range(var.agent_count) :
    "k3s-agent-${i + 1}" => {
      vmid = var.agent_vmid_start + i
      ip   = cidrhost(var.node_cidr, var.agent_ip_start + i)
    }
  }
}

# ── Server (control-plane) VMs ─────────────────────────────────────────────
resource "proxmox_virtual_environment_vm" "k3s_server" {
  for_each = local.servers

  name        = each.key
  vm_id       = each.value.vmid
  node_name   = var.proxmox_node
  tags        = ["k3s", "server", "tofu"]
  description = "k3s control-plane — managed by OpenTofu. DO NOT edit manually."

  clone {
    vm_id   = var.template_vmid
    full    = true
    retries = 3
  }

  cpu {
    cores = var.server_cores
    type  = "x86-64-v2-AES" # good for Ryzen 5600x
  }

  memory {
    dedicated = var.server_memory
    floating  = 0 # disable ballooning; k3s needs predictable RAM
  }

  disk {
    datastore_id = var.storage_pool
    interface    = "scsi0"
    size         = var.server_disk_size
    file_format  = "raw"
    discard      = "on"
    ssd          = true
    iothread     = true
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
    vlan_id = var.vlan_id
  }

  operating_system { type = "l26" }
  agent {
    enabled = true
    trim    = true
  }

  initialization {
    datastore_id = var.storage_pool
    ip_config {
      ipv4 {
        address = "${each.value.ip}/${var.node_prefix}"
        gateway = var.gateway
      }
    }
    dns { servers = [var.dns_server] }
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id
  }

  lifecycle {
    ignore_changes = [clone, initialization[0].user_data_file_id]
  }
}

# ── Agent (worker) VMs ─────────────────────────────────────────────────────
resource "proxmox_virtual_environment_vm" "k3s_agent" {
  for_each = local.agents

  name        = each.key
  vm_id       = each.value.vmid
  node_name   = var.proxmox_node
  tags        = ["k3s", "agent", "tofu"]
  description = "k3s worker node — managed by OpenTofu. DO NOT edit manually."

  clone {
    vm_id   = var.template_vmid
    full    = true
    retries = 3
  }

  cpu {
    cores = var.agent_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.agent_memory
    floating  = 0
  }

  disk {
    datastore_id = var.storage_pool
    interface    = "scsi0"
    size         = var.agent_disk_size
    file_format  = "raw"
    discard      = "on"
    ssd          = true
    iothread     = true
  }

  network_device {
    bridge  = var.network_bridge
    model   = "virtio"
    vlan_id = var.vlan_id
  }

  operating_system { type = "l26" }
  agent {
    enabled = true
    trim    = true
  }

  initialization {
    datastore_id = var.storage_pool
    ip_config {
      ipv4 {
        address = "${each.value.ip}/${var.node_prefix}"
        gateway = var.gateway
      }
    }
    dns { servers = [var.dns_server] }
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id
  }

  lifecycle {
    ignore_changes = [clone, initialization[0].user_data_file_id]
  }
}
