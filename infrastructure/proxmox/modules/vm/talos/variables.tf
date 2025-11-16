variable "name" {
  description = "Virtual machine name."
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
  description = "Additional tags to apply to the VM (\"k8s\", \"talos\")."
  type        = list(string)
  default     = []
}

variable "on_boot" {
  description = "Whether the virtual machine should start on host boot."
  type        = bool
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
  description = "Disk size in GiB."
  type        = number
}
