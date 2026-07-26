variable "op_service_account_token" {
  description = "1Password service account token."
  type        = string
  sensitive   = true
}

variable "op_vault_id" {
  description = "1Password vault UUID (the SDK requires the UUID)."
  type        = string
}
