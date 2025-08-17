data "proxmox_virtual_environment_node" "pve_01" {
  node_name = "pve-01"
}

data "proxmox_virtual_environment_vm" "k8s_template" {
  node_name = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id     = 9998
}

data "proxmox_virtual_environment_vm" "ubuntu_template" {
  node_name = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id     = 9999
}

resource "proxmox_virtual_environment_vm" "k8s_prod_control_plane_01" {
  name      = "k8s-prod-control-plane-01"
  node_name = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id     = 1000
  tags      = ["k8s", "prod"]
  on_boot   = true

  clone {
    vm_id = data.proxmox_virtual_environment_vm.k8s_template.vm_id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 8589
  }

  cpu {
    cores = 4
  }
}

resource "proxmox_virtual_environment_vm" "k8s_prod_worker_01" {
  name      = "k8s-prod-worker-01"
  node_name = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id     = 1001
  tags      = ["k8s", "prod"]
  on_boot   = true

  clone {
    vm_id = data.proxmox_virtual_environment_vm.k8s_template.vm_id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 8589
  }

  cpu {
    cores = 4
  }
}

resource "proxmox_virtual_environment_vm" "k8s_prod_worker_02" {
  name      = "k8s-prod-worker-02"
  node_name = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id     = 1002
  tags      = ["k8s", "prod"]
  on_boot   = true

  clone {
    vm_id = data.proxmox_virtual_environment_vm.k8s_template.vm_id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 8589
  }

  cpu {
    cores = 4
  }
}

output "k8s_mac_addresses" {
  value = {
    k8s_control_plane_01 = proxmox_virtual_environment_vm.k8s_prod_control_plane_01.mac_addresses
    k8s_worker_01        = proxmox_virtual_environment_vm.k8s_prod_worker_01.mac_addresses
    k8s_worker_02        = proxmox_virtual_environment_vm.k8s_prod_worker_02.mac_addresses
  }
}