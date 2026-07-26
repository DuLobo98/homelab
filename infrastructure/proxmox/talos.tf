resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode({
    customization = {
      systemExtensions = {
        officialExtensions = [
          "siderolabs/qemu-guest-agent",
          # Required by Longhorn
          "siderolabs/iscsi-tools",
          "siderolabs/util-linux-tools",
        ]
      }
    }
  })
}

data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = "nocloud"
}

# Generates a new PKI on every apply. It's persisted once in onepassword.tf and 
# read back from there so the cluster identity stays stable;
ephemeral "talos_machine_secrets" "generated" {}

ephemeral "talos_client_configuration" "this" {
  cluster_name    = var.cluster_name
  machine_secrets = local.talos_secrets.machine_secrets
  endpoints       = values(local.k8s_prod_node_ips)
}

ephemeral "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.cluster_vip}:6443"
  machine_type     = "controlplane"
  machine_secrets  = local.talos_secrets.machine_secrets
  talos_version    = var.talos_version
}

resource "talos_machine_configuration_apply" "this" {
  for_each = local.k8s_prod_talos

  depends_on              = [module.k8s_prod_talos]
  client_configuration_wo = local.talos_secrets.client_configuration
  node                    = local.k8s_prod_node_ips[each.key]

  machine_configuration_input_wo = ephemeral.talos_machine_configuration.controlplane.machine_configuration

  config_patches = [
    yamlencode({
      machine = {
        network = {
          interfaces = [{
            deviceSelector = { physical = true }
            vip            = { ip = var.cluster_vip }
          }]
        }
        install = {
          disk  = "/dev/sda"
          image = data.talos_image_factory_urls.this.urls.installer
        }
        kubelet = {
          extraMounts = [{
            destination = "/var/mnt/longhorn"
            type        = "bind"
            source      = "/var/mnt/longhorn"
            options     = ["bind", "rshared", "rw"]
          }]
        }
      }
      cluster = {
        network                        = { cni = { name = "none" } }
        proxy                          = { disabled = true }
        allowSchedulingOnControlPlanes = true
      }
    }),
    yamlencode({
      apiVersion = "v1alpha1"
      kind       = "UserVolumeConfig"
      name       = "longhorn"
      provisioning = {
        diskSelector = { match = "disk.dev_path == \"/dev/sdb\"" }
        grow         = true
        # Just a safety cap so the volume can't claim the entire disk if the disk is larger than expected.
        maxSize = "500GB"
      }
    }),
    # The router's DNS drops NS queries, which Talos uses to health check resolvers
    yamlencode({
      apiVersion = "v1alpha1"
      kind       = "ResolverConfig"
      nameservers = [
        { address = "1.1.1.1" },
        { address = "8.8.8.8" },
      ]
    }),
  ]
}

resource "talos_machine_bootstrap" "this" {
  depends_on              = [talos_machine_configuration_apply.this]
  client_configuration_wo = local.talos_secrets.client_configuration
  node                    = local.k8s_prod_node_ips["k8s_prod_control_plane_01"]
}
