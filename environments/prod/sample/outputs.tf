output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.tfc_oidc.oidc_provider_arn
}

output "plan_role_arn" {
  description = "Plan role ARN"
  value       = module.tfc_roles.plan_role_arn
}

output "apply_role_arn" {
  description = "Apply role ARN"
  value       = module.tfc_roles.apply_role_arn
}