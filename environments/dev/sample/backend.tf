terraform {
  backend "s3" {
    bucket  = var.backend_bucket
    key     = var.project_name
    region  = var.backend_region
    profile = var.backend_profile
  }
}