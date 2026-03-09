output "server_ips" {
  description = "Map of server name → IP"
  value = {
    for name, vm in proxmox_virtual_environment_vm.k3s_server :
    name => vm.initialization[0].ip_config[0].ipv4[0].address
  }
}

output "agent_ips" {
  description = "Map of agent name → IP"
  value = {
    for name, vm in proxmox_virtual_environment_vm.k3s_agent :
    name => vm.initialization[0].ip_config[0].ipv4[0].address
  }
}

output "first_server_ip" {
  description = "Primary init node IP — used by Ansible and for kubeconfig"
  value       = proxmox_virtual_environment_vm.k3s_server["k3s-server-1"].initialization[0].ip_config[0].ipv4[0].address
}
