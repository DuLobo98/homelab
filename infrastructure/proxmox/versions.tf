terraform {
  required_version = ">= 1.11"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.122.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.12.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 3.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
  }
}
