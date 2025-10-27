terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.target_region
  profile = var.target_profile
}

module "tfc_baseline" {
  source = "../../../modules/tfc-baseline"

  project_name     = var.project_name
  environment      = var.environment
  tfc_organization = var.tfc_organization
  tfc_project      = var.tfc_project
  tfc_workspace = var.tfc_workspace

  plan_policy_arns = var.plan_policy_arns
  plan_custom_policies = {
    for filename in fileset("${path.module}/policies/plan", "*.json") :
    trimsuffix(filename, ".json") => file("${path.module}/policies/plan/${filename}")
  }

  apply_policy_arns = var.apply_policy_arns
  apply_custom_policies = {
    for filename in fileset("${path.module}/policies/apply", "*.json") :
    trimsuffix(filename, ".json") => file("${path.module}/policies/apply/${filename}")
  }

  # Trusted role switching (dev environment only)
  trusted_role_arn = var.trusted_role_arn
}