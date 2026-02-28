resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve-01"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

locals {
  k8s_prod_vms = {
    k8s_prod_control_plane_01 = {
      node_name        = "pve-01"
      name             = "k8s-prod-control-plane-01"
      vm_id            = 1000
      tags             = ["prod", "k8s"]
      on_boot          = true
      memory_dedicated = 6144
      cpu_cores        = 4
      disk_size        = 100
      ipv4_address     = "192.168.1.200/24"
      ipv4_gateway     = "192.168.1.1"
    }
    k8s_prod_worker_01 = {
      node_name        = "pve-01"
      name             = "k8s-prod-worker-01"
      vm_id            = 1001
      tags             = ["prod", "k8s"]
      on_boot          = true
      memory_dedicated = 4096
      cpu_cores        = 4
      disk_size        = 100
      ipv4_address     = "192.168.1.201/24"
      ipv4_gateway     = "192.168.1.1"
    }
    k8s_prod_worker_02 = {
      node_name        = "pve-01"
      name             = "k8s-prod-worker-02"
      vm_id            = 1002
      tags             = ["prod", "k8s"]
      on_boot          = true
      memory_dedicated = 4096
      cpu_cores        = 4
      disk_size        = 100
      ipv4_address     = "192.168.1.202/24"
      ipv4_gateway     = "192.168.1.1"
    }
  }
}

module "k8s_prod_vms" {
  source   = "./modules/vm/ubuntu"
  for_each = local.k8s_prod_vms

  name                  = each.value.name
  node_name             = each.value.node_name
  vm_id                 = each.value.vm_id
  tags                  = each.value.tags
  on_boot               = each.value.on_boot
  memory_dedicated      = each.value.memory_dedicated
  cpu_cores             = each.value.cpu_cores
  disk_size             = each.value.disk_size
  ipv4_address          = each.value.ipv4_address
  ipv4_gateway          = each.value.ipv4_gateway
  ssh_public_key        = var.ssh_public_key
  cloud_image_import_id = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
}

output "k8s_network_details" {
  description = "MAC and IPv4 addresses for each Kubernetes VM."
  value = {
    for key in keys(local.k8s_prod_vms) :
    key => {
      mac_address  = module.k8s_prod_vms[key].mac_address
      ipv4_address = local.k8s_prod_vms[key].ipv4_address
    }
  }
}