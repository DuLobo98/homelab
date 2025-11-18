variable "proxmox_endpoint" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token"
  type        = string
}

variable "proxmox_insecure" {
  description = "Proxmox API insecure skip verify"
  type        = bool
  default     = false
}

variable "proxmox_ssh_username" {
  description = "SSH username for Proxmox host"
  type        = string
  default     = "root"
}

variable "proxmox_ssh_private_key" {
  description = "SSH private key for Proxmox host"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to be used for VM access."
  type        = string
}