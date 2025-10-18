output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3_backend.s3_bucket_name
}

output "s3_region" {
  description = "Region of the S3 bucket"
  value = var.aws_region
}

output "backend_config" {
  description = "Backend configuration for use in other Terraform configurations"
  value = {
    bucket  = module.s3_backend.s3_bucket_name
    key     = "YOUR_PROJECT_NAME"
    region  = var.aws_region
    encrypt = true
  }
}