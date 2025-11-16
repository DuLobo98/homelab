resource "proxmox_virtual_environment_vm" "main" {
  name            = var.name
  node_name       = var.node_name
  vm_id           = var.vm_id
  tags            = concat(var.tags, ["talos", "k8s"])
  on_boot         = var.on_boot
  boot_order      = ["ide2", "scsi0"]
  keyboard_layout = "pt"

  agent {
    enabled = true
  }

  memory {
    dedicated = var.memory_dedicated
  }

  cpu {
    cores   = var.cpu_cores
    sockets = 1
    type    = "x86-64-v2-AES"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "data-lvm"
    size         = var.disk_size
  }

  cdrom {
    interface = "ide2"
    file_id   = "local:iso/talos-1-11-3.iso"
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }
}
