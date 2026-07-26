locals {
  default_tags = {
    "managed-by" = "terraform"
  }

  default_tags_flattened = [for k, v in local.default_tags : "${k}-${v}"]
}
