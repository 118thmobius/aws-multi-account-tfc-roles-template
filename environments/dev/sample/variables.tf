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