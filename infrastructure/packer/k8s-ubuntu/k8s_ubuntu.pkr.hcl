packer {
    required_plugins {
        proxmox = {
            version = "1.2.3"
            source  = "github.com/hashicorp/proxmox"
        }
    }
}

variable "proxmox_url" {
  type    = string
  default = "https://proxmox.example.com:8006/api2/json"
}

variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

source "proxmox-iso" "k8s_ubuntu" {
  proxmox_url              = var.proxmox_url
  username                 = var.proxmox_username
  password                 = var.proxmox_password
  node                     = "pve"
  insecure_skip_tls_verify = true

  vm_name              = "ubuntu-k8s-template"
  vm_id                = 9000
  template_description = "Ubuntu 22.04 template for Kubernetes"

  iso_file       = "local:iso/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum   = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_storage_pool = "local"
  unmount_iso    = true

  qemu_agent = true
  scsi_controller = "virtio-scsi-pci"

  disks {
    disk_size         = "20G"
    format            = "qcow2"
    storage_pool      = "local-lvm"
    type              = "scsi"
  }

  cores    = 2
  memory   = 2048
  
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = false
  }

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot      = "c"
  boot_wait = "5s"

  http_directory = "http"
  http_bind_address = "0.0.0.0"
  http_port_min = 8802
  http_port_max = 8802

  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout = "20m"
}

build {
  name = "ubuntu-k8s"
  sources = ["source.proxmox-iso.k8s_ubuntu"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo apt update",
      "sudo apt install -y qemu-guest-agent",
      "sudo systemctl enable qemu-guest-agent",
      "sudo systemctl start qemu-guest-agent",
      "echo 'Template creation complete'"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo apt clean",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo rm /var/lib/dbus/machine-id",
      "sudo ln -s /etc/machine-id /var/lib/dbus/machine-id"
    ]
  }
}