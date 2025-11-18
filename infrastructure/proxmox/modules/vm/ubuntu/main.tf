resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name            = var.name
  node_name       = var.node_name
  vm_id           = var.vm_id
  tags            = concat(var.tags, ["cloud-init", "terraform"])
  on_boot         = var.on_boot
  keyboard_layout = "pt"

  agent {
    enabled = var.agent_enabled
  }

  memory {
    dedicated = var.memory_dedicated
  }

  cpu {
    cores = var.cpu_cores
    sockets = 1
  }

  disk {
    interface    = "scsi0"
    datastore_id = "data-lvm"
    size         = var.disk_size
    import_from  = var.cloud_image_import_id
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
}
