variable "project_name" {
  description = "Project name"
  type        = string
  default     = "sample-project"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "target_profile" {
  description = "Target AWS profile"
  type        = string
  default     = "default"
}

variable "target_region" {
  description = "Target AWS region"
  type        = string
  default     = "us-east-1"
}

variable "tfc_organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "tfc_project" {
  description = "Terraform Cloud project name"
  type        = string
}

variable "tfc_workspace" {
  description = "Terraform Cloud workspace name"
  type        = string
}

variable "plan_policy_arns" {
  description = "AWS managed policy ARN list for plan role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

variable "apply_policy_arns" {
  description = "AWS managed policy ARN list for apply role"
  type        = list(string)
  default     = []
}

variable "trusted_role_arn" {
  description = "Trusted role ARN for role switching (dev environment only)"
  type        = string
  default     = ""

  validation {
    condition     = var.trusted_role_arn == "" || can(regex("^arn:aws:iam::[0-9]{12}:role/.+$", var.trusted_role_arn))
    error_message = "The trusted_role_arn must be a valid AWS IAM role ARN (e.g., arn:aws:iam::123456789012:role/MyRole) or empty string."
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.target_region
  profile = var.target_profile
}

module "tfc_baseline" {
  source = "../../../modules/tfc-baseline"

  project_name     = var.project_name
  environment      = var.environment
  tfc_organization = var.tfc_organization
  tfc_project      = var.tfc_project
  tfc_workspace = var.tfc_workspace

  plan_policy_arns = var.plan_policy_arns
  plan_custom_policies = {
    for filename in fileset("${path.module}/policies/plan", "*.json") :
    trimsuffix(filename, ".json") => file("${path.module}/policies/plan/${filename}")
  }

  apply_policy_arns = var.apply_policy_arns
  apply_custom_policies = {
    for filename in fileset("${path.module}/policies/apply", "*.json") :
    trimsuffix(filename, ".json") => file("${path.module}/policies/apply/${filename}")
  }

  # Trusted role switching (dev environment only)
  trusted_role_arn = var.trusted_role_arn
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.tfc_baseline.oidc_provider_arn
}

output "plan_role_arn" {
  description = "Plan role ARN"
  value       = module.tfc_baseline.plan_role_arn
}

output "apply_role_arn" {
  description = "Apply role ARN"
  value       = module.tfc_baseline.apply_role_arn
}