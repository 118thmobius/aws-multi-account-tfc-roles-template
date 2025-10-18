output "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  value       = module.tfc_oidc.oidc_provider_arn
}

output "plan_role_arn" {
  description = "ARN of the IAM role for plan operations"
  value       = module.tfc_roles.plan_role_arn
}

output "apply_role_arn" {
  description = "ARN of the IAM role for apply operations"
  value       = module.tfc_roles.apply_role_arn
}