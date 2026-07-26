terraform {
  backend "s3" {
    bucket         = "homelab-terraform-state"
    key            = "proxmox/terraform.tfstate"
    region         = "us-east-1" # Dummy region for RustFS S3 backend. It does not implement AWS-style regions.
    use_path_style = true
    use_lockfile   = true

    # RustFS S3 backend does not implement all AWS S3 API features.
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
