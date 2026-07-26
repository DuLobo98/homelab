provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure

  ssh {
    agent       = false
    username    = var.proxmox_ssh_username
    private_key = var.proxmox_ssh_private_key
  }
}

provider "talos" {}

provider "onepassword" {
  service_account_token = var.op_service_account_token
}
