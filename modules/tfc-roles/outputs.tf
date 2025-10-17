output "plan_role_arn" {
  description = "Plan role ARN"
  value       = aws_iam_role.tfc_plan_role.arn
}

output "apply_role_arn" {
  description = "Apply role ARN"
  value       = aws_iam_role.tfc_apply_role.arn
}