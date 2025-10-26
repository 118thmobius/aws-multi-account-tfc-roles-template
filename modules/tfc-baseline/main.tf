module "tfc_oidc" {
  source = "../tfc-oidc"

  project_name = var.project_name
  environment  = var.environment
}

module "tfc_roles" {
  source = "../tfc-roles"

  project_name      = var.project_name
  environment       = var.environment
  oidc_provider_arn = module.tfc_oidc.oidc_provider_arn
  tfc_organization  = var.tfc_organization
  tfc_project       = var.tfc_project
  tfc_workspace     = var.tfc_workspace

  plan_policy_arns      = var.plan_policy_arns
  plan_custom_policies  = var.plan_custom_policies
  apply_policy_arns     = var.apply_policy_arns
  apply_custom_policies = var.apply_custom_policies
}