variable "name" {
  description = "Virtual machine name."
  type        = string
}

variable "talos_image_import_id" {
  description = "ID of the Talos nocloud image to import for the OS disk."
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
  description = "Enable the QEMU guest agent on the VM. Requires the siderolabs/qemu-guest-agent extension in the image."
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

variable "os_datastore_id" {
  description = "Proxmox datastore backing the Talos OS disk."
  type        = string
  default     = "data"
}

variable "data_datastore_id" {
  description = "Proxmox datastore backing the dedicated data disk."
  type        = string
  default     = "data-lvm"
}

variable "disk_size" {
  description = "Size of the Talos OS disk in GiB. Talos sizes the EPHEMERAL (/var) partition at install time and does NOT grow it when the disk is enlarged later, that needs a drain plus `talosctl upgrade --preserve`."
  type        = number
}

variable "data_disk_size" {
  description = "Size of the dedicated data disk in GiB. Growing it takes a machine-config update and usually a node reboot, bumping this value alone is not sufficient."
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
