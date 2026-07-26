locals {
  k8s_prod_talos = {
    k8s_prod_control_plane_01 = {
      node_name         = "pve-01"
      name              = "k8s-prod-control-plane-01"
      vm_id             = 1001
      tags              = ["prod"]
      on_boot           = true
      memory_dedicated  = 12288
      cpu_cores         = 4
      os_datastore_id   = "local-lvm"
      data_datastore_id = "data-lvm"
      disk_size         = 50
      data_disk_size    = 200
      ipv4_address      = "192.168.1.211/24"
      ipv4_gateway      = "192.168.1.1"
    }
    k8s_prod_control_plane_02 = {
      node_name         = "pve-02"
      name              = "k8s-prod-control-plane-02"
      vm_id             = 1002
      tags              = ["prod"]
      on_boot           = true
      memory_dedicated  = 12288
      cpu_cores         = 4
      os_datastore_id   = "local-lvm"
      data_datastore_id = "data-lvm"
      disk_size         = 50
      data_disk_size    = 200
      ipv4_address      = "192.168.1.212/24"
      ipv4_gateway      = "192.168.1.1"
    }
    k8s_prod_control_plane_03 = {
      node_name         = "pve-03"
      name              = "k8s-prod-control-plane-03"
      vm_id             = 1003
      tags              = ["prod"]
      on_boot           = true
      memory_dedicated  = 12288
      cpu_cores         = 4
      os_datastore_id   = "local-lvm"
      data_datastore_id = "data-lvm"
      disk_size         = 50
      data_disk_size    = 200
      ipv4_address      = "192.168.1.213/24"
      ipv4_gateway      = "192.168.1.1"
    }
  }

  k8s_prod_node_ips = {
    for key, vm in local.k8s_prod_talos : key => split("/", vm.ipv4_address)[0]
  }
}

resource "proxmox_download_file" "talos_image" {
  for_each = toset(distinct([for vm in local.k8s_prod_talos : vm.node_name]))

  content_type            = "iso"
  datastore_id            = "local"
  node_name               = each.value
  url                     = data.talos_image_factory_urls.this.urls.disk_image
  decompression_algorithm = "zst"
  file_name               = "talos-${var.talos_version}-nocloud-amd64.img"
  # For a compressed download the URL reports the compressed size while the stored
  # file is decompressed, so the provider's size check never matches and would
  # replace the image (and cascade into VM replacement) on every apply. Disabling
  # it stops that, a new talos_version changes file_name and re-downloads the image
  overwrite = false
}

module "k8s_prod_talos" {
  source   = "./modules/vm/talos"
  for_each = local.k8s_prod_talos

  name                  = each.value.name
  node_name             = each.value.node_name
  vm_id                 = each.value.vm_id
  tags                  = concat(local.default_tags_flattened, each.value.tags)
  on_boot               = each.value.on_boot
  memory_dedicated      = each.value.memory_dedicated
  cpu_cores             = each.value.cpu_cores
  os_datastore_id       = each.value.os_datastore_id
  data_datastore_id     = each.value.data_datastore_id
  disk_size             = each.value.disk_size
  data_disk_size        = each.value.data_disk_size
  ipv4_address          = each.value.ipv4_address
  ipv4_gateway          = each.value.ipv4_gateway
  talos_image_import_id = proxmox_download_file.talos_image[each.value.node_name].id
}
