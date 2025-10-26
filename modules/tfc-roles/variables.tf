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