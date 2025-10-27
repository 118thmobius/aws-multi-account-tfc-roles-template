variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN"
  type        = string
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
  default     = []
}

variable "plan_custom_policies" {
  description = "Custom policy map for plan role"
  type        = map(string)
  default     = {}
}

variable "apply_policy_arns" {
  description = "AWS managed policy ARN list for apply role"
  type        = list(string)
  default     = []
}

variable "apply_custom_policies" {
  description = "Custom policy map for apply role"
  type        = map(string)
  default     = {}
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