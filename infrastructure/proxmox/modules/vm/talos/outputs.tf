output "vm_id" {
  description = "Identifier of the created Proxmox VM."
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "mac_address" {
  description = "MAC address assigned to the VM network."
  value       = proxmox_virtual_environment_vm.this.network_device[0].mac_address
}

output "ipv4_address" {
  description = "IPv4 address (CIDR) configured on the VM."
  value       = var.ipv4_address
}
