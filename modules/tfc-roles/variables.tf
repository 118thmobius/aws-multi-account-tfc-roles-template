variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名（dev/prod）"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDCプロバイダARN"
  type        = string
}

variable "tfc_organization" {
  description = "Terraform Cloud組織名"
  type        = string
}

variable "tfc_project" {
  description = "Terraform Cloudプロジェクト名"
  type        = string
}

variable "plan_policy_arns" {
  description = "Plan用AWSマネージドポリシーARN配列"
  type        = list(string)
  default     = []
}

variable "plan_custom_policies" {
  description = "Plan用カスタムポリシーマップ"
  type        = map(string)
  default     = {}
}

variable "apply_policy_arns" {
  description = "Apply用AWSマネージドポリシーARN配列"
  type        = list(string)
  default     = []
}

variable "apply_custom_policies" {
  description = "Apply用カスタムポリシーマップ"
  type        = map(string)
  default     = {}
}