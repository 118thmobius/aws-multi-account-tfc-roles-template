terraform {
  backend "s3" {
    # Backend configuration will be provided via:
    # - terraform init -backend-config arguments
    # - ../backend.hcl file
    # - environment variables
  }
}