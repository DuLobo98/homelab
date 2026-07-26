resource "proxmox_virtual_environment_vm" "this" {
  name            = var.name
  node_name       = var.node_name
  vm_id           = var.vm_id
  tags            = concat(var.tags, ["k8s", "talos"])
  on_boot         = var.on_boot
  keyboard_layout = "pt"

  agent {
    enabled = var.agent_enabled
  }

  memory {
    dedicated = var.memory_dedicated
  }

  cpu {
    # Talos requires the x86-64-v2-AES CPU type
    type    = "x86-64-v2-AES"
    cores   = var.cpu_cores
    sockets = 1
  }

  # OS disk
  disk {
    interface    = "scsi0"
    datastore_id = var.os_datastore_id
    size         = var.disk_size
    file_id      = var.talos_image_import_id
    discard      = "on"
    ssd          = true
  }

  # Data disk
  disk {
    interface    = "scsi1"
    datastore_id = var.data_datastore_id
    size         = var.data_disk_size
    discard      = "on"
    ssd          = true
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
  }
}
