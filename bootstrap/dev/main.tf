terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3_backend" {
  source = "../../modules/s3-backend"

  bucket_name = var.bucket_name
  environment = var.environment
}