output "plan_role_arn" {
  description = "Plan用ロールARN"
  value       = aws_iam_role.tfc_plan_role.arn
}

output "apply_role_arn" {
  description = "Apply用ロールARN"
  value       = aws_iam_role.tfc_apply_role.arn
}