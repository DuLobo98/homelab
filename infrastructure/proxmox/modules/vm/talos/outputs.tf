output "mac_address" {
  description = "MAC address assigned to the primary network interface (eth0)."
  value       = proxmox_virtual_environment_vm.main.network_device[0].mac_address
}
