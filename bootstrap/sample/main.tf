terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

provider "aws" {
  region = var.aws_region
}

module "s3_backend" {
  source = "../../modules/s3-backend"
  bucket_name = var.bucket_name
  environment = var.environment
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3_backend.s3_bucket_name
}

output "s3_region" {
  description = "Region of the S3 bucket"
  value = var.aws_region
}