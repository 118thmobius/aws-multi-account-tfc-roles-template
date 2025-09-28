output "oidc_provider_arn" {
  description = "OIDCプロバイダARN"
  value       = module.tfc_oidc.oidc_provider_arn
}

output "plan_role_arn" {
  description = "Plan用ロールARN"
  value       = module.tfc_roles.plan_role_arn
}

output "apply_role_arn" {
  description = "Apply用ロールARN"
  value       = module.tfc_roles.apply_role_arn
}