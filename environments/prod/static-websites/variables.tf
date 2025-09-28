variable "project_name" {
  description = "プロジェクト名"
  type        = string
  default     = "static-websites"
}

variable "environment" {
  description = "環境名"
  type        = string
  default     = "prod"
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
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

variable "apply_policy_arns" {
  description = "Apply用AWSマネージドポリシーARN配列"
  type        = list(string)
  default     = []
}