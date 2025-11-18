variable "name" {
  description = "Virtual machine name."
  type        = string
}

variable "cloud_image_import_id" {
  description = "ID of the cloud image to import for the VM disk."
  type        = string
}

variable "node_name" {
  description = "Proxmox node where the VM will run."
  type        = string
}

variable "vm_id" {
  description = "Identifier to assign to the virtual machine."
  type        = number
}

variable "tags" {
  description = "List of tags to apply to the VM."
  type        = list(string)
  default     = []
}

variable "on_boot" {
  description = "Whether the virtual machine should start on host boot."
  type        = bool
  default     = true
}

variable "agent_enabled" {
  description = "Enable the QEMU guest agent on the VM."
  type        = bool
  default     = true
}

variable "memory_dedicated" {
  description = "Amount of dedicated memory (in MiB)."
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores to allocate."
  type        = number
}

variable "disk_size" {
  description = "Size of the primary disk in GiB."
  type        = number
}

variable "ipv4_address" {
  description = "IPv4 address (CIDR) or 'dhcp' for the VM network."
  type        = string
  default     = "dhcp"
}

variable "ipv4_gateway" {
  description = "IPv4 gateway for the VM network. Required if a static IP is set."
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for accessing the VM."
  type        = string
}