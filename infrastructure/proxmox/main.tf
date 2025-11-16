data "proxmox_virtual_environment_node" "pve_01" {
  node_name = "pve-01"
}

locals {
  k8s_prod_vms = {
    k8s_prod_control_plane_01 = {
      name             = "k8s-prod-control-plane-01"
      vm_id            = 1000
      tags             = ["prod"]
      on_boot          = true
      memory_dedicated = 3072
      cpu_cores        = 4
      disk_size        = 100
    }
    k8s_prod_worker_01 = {
      name              = "k8s-prod-worker-01"
      vm_id             = 1001
      tags              = ["prod"]
      on_boot           = true
      memory_dedicated  = 3072
      cpu_cores         = 4
      disk_size         = 100
    }
    k8s_prod_worker_02 = {
      name              = "k8s-prod-worker-02"
      vm_id             = 1002
      tags              = ["prod"]
      on_boot           = true
      memory_dedicated  = 3072
      cpu_cores         = 4
      disk_size         = 100
    }
  }

}

module "k8s_prod_vms" {
  source   = "./modules/vm/talos"
  for_each = local.k8s_prod_vms

  name             = each.value.name
  node_name        = data.proxmox_virtual_environment_node.pve_01.node_name
  vm_id            = each.value.vm_id
  tags             = each.value.tags
  on_boot          = each.value.on_boot
  memory_dedicated = each.value.memory_dedicated
  cpu_cores        = each.value.cpu_cores
  disk_size        = each.value.disk_size
}

output "k8s_mac_addresses" {
  value = {
    for key in keys(local.k8s_prod_vms) :
    key => module.k8s_prod_vms[key].mac_address
  }
}