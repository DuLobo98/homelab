variable "cluster_name" {
  description = "Talos cluster name."
  type        = string
  default     = "k8s-prod"
}

variable "cluster_vip" {
  description = "Layer 2 virtual IP shared by the control planes."
  type        = string
  default     = "192.168.1.210"
}

variable "talos_version" {
  description = "Talos Linux version"
  type        = string
  default     = "v1.13.7"
}
