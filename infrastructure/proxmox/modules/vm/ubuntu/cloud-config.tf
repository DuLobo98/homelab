resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = <<EOF
#cloud-config
hostname: ${var.name}
timezone: UTC
users:
  - name: ltwadmin
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${var.ssh_public_key}
    sudo: ALL=(ALL) NOPASSWD:ALL
package_update: true
packages:
  - qemu-guest-agent
  - open-iscsi
  - nfs-common
  - cryptsetup
  - dmsetup
  - util-linux
runcmd:
  - systemctl enable qemu-guest-agent
  - systemctl start qemu-guest-agent
  - modprobe iscsi_tcp
  - systemctl enable iscsid
  - systemctl start iscsid
  # multipathd may need to be disabled if starting to show problems with longhorn https://longhorn.io/kb/troubleshooting-volume-with-multipath/
  - echo "done" > /tmp/cloud-config.done
EOF

    file_name = "user-data-cloud-config-${var.name}.yaml"
  }
}
