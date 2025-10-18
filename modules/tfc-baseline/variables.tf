variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
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

variable "plan_policy_arns" {
  description = "List of AWS managed policy ARNs to attach to the plan IAM role"
  type        = list(string)
  default     = []
}

variable "plan_custom_policies" {
  description = "Custom policies to attach to the plan IAM role"
  type        = map(string)
  default     = {}
}

variable "apply_policy_arns" {
  description = "List of AWS managed policy ARNs to attach to the apply IAM role"
  type        = list(string)
  default     = []
}

variable "apply_custom_policies" {
  description = "Custom policies to attach to the apply IAM role"
  type        = map(string)
  default     = {}
}