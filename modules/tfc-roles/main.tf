resource "aws_iam_role" "tfc_plan_role" {
  name = "${var.project_name}-${var.environment}-tfc-plan-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "app.terraform.io:aud" = "aws.workload.identity"
          }
          StringLike = {
            "app.terraform.io:sub" = "organization:${var.tfc_organization}:project:${var.tfc_project}:workspace:*:run_phase:plan"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-tfc-plan-role"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "tfc_apply_role" {
  name = "${var.project_name}-${var.environment}-tfc-apply-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "app.terraform.io:aud" = "aws.workload.identity"
          }
          StringLike = {
            "app.terraform.io:sub" = "organization:${var.tfc_organization}:project:${var.tfc_project}:workspace:*:run_phase:apply"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-tfc-apply-role"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "plan_managed_policies" {
  for_each   = toset(var.plan_policy_arns)
  role       = aws_iam_role.tfc_plan_role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "apply_managed_policies" {
  for_each   = toset(var.apply_policy_arns)
  role       = aws_iam_role.tfc_apply_role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "plan_custom_policies" {
  for_each = var.plan_custom_policies
  name     = each.key
  role     = aws_iam_role.tfc_plan_role.id
  policy   = each.value
}

resource "aws_iam_role_policy" "apply_custom_policies" {
  for_each = var.apply_custom_policies
  name     = each.key
  role     = aws_iam_role.tfc_apply_role.id
  policy   = each.value
}