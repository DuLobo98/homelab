resource "onepassword_item" "talos_secrets" {
  vault    = var.op_vault_id
  title    = "talos-${var.cluster_name}"
  category = "secure_note"
  tags     = local.default_tags_flattened

  note_value_wo = jsonencode({
    machine_secrets      = ephemeral.talos_machine_secrets.generated.machine_secrets
    client_configuration = ephemeral.talos_machine_secrets.generated.client_configuration
  })
  # Terraform only re-sends note_value_wo when this version changes. The source
  # regenerates fresh PKI every apply, so keeping it at 1 stores the secrets once
  # and never overwrites them. Bump only to deliberately rotate.
  note_value_wo_version = 1

  lifecycle {
    prevent_destroy = true
  }
}

ephemeral "onepassword_item" "talos_secrets" {
  vault = var.op_vault_id
  uuid  = onepassword_item.talos_secrets.uuid
}

locals {
  talos_secrets = jsondecode(ephemeral.onepassword_item.talos_secrets.note_value)
}

resource "onepassword_item" "talosconfig" {
  vault    = var.op_vault_id
  title    = "talosconfig-${var.cluster_name}"
  category = "secure_note"
  tags     = local.default_tags_flattened

  note_value_wo = ephemeral.talos_client_configuration.this.talos_config
  # Write-only values aren't tracked in state, so edits to the talosconfig won't
  # reach 1Password on their own. Bump this version to push the current value.
  note_value_wo_version = 1
}
