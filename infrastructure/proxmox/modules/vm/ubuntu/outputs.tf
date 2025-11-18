output "vm_id" {
  description = "Identifier of the created Proxmox VM."
  value       = proxmox_virtual_environment_vm.ubuntu_vm.vm_id
}

output "mac_address" {
  description = "MAC address assigned to the VM network."
  value       = proxmox_virtual_environment_vm.ubuntu_vm.network_device[0].mac_address
}