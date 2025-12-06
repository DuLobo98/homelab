proxmox_endpoint  = "op://homelab/tailscale/proxmox_endpoint"
proxmox_api_token = "op://homelab/proxmox/proxmox_token"
proxmox_insecure  = true
proxmox_ssh_private_key = <<EOT
op://homelab/proxmox_ssh_key/private key
EOT
ssh_public_key = "op://homelab/proxmox_ssh_key/public key"