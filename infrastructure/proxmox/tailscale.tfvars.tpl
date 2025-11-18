proxmox_endpoint  = "op://Homelab/terraform/proxmox_endpoint_tailscale"
proxmox_api_token = "op://Homelab/terraform/proxmox_token"
proxmox_insecure  = true
proxmox_ssh_private_key = <<EOT
op://Homelab/Proxmox SSH Key/private key
EOT
ssh_public_key = "op://Homelab/Proxmox SSH Key/public key"