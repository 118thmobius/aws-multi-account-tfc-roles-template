# AWS TFC Roles Project

English | [日本語](README.md)

A Terraform project to create IAM roles and OIDC providers for deploying AWS resources using Terraform Cloud (TFC) in a multi-account AWS Organization configuration.

## Project Structure

```
aws-multi-account-tfc-roles/
├── modules/
│   ├── tfc-oidc/               # OIDC Provider Module
│   └── tfc-roles/              # IAM Roles Module
├── environments/
│   ├── dev/                    # Development Environment
│   │   └── sample/
│   │       ├── policies/
│   │       │   ├── plan/       # Custom Policies for Plan
│   │       │   └── apply/      # Custom Policies for Apply
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── terraform.tfvars.example
│   └── prod/                   # Production Environment
│       └── sample/
└── README.md
```

## Module Overview

### tfc-oidc Module
- Creates OIDC Provider
- Authentication infrastructure for Terraform Cloud

### tfc-roles Module
- Plan IAM Role (read-only)
- Apply IAM Role (modification permissions)
- Management of AWS managed and custom policies

## Created Resources

The following resources are created for each environment (dev/prod):

- **OIDC Provider**: For Terraform Cloud (1)
- **IAM Roles**: Plan and Apply roles (2)
  - Plan: For terraform plan execution (read-only)
  - Apply: For terraform apply execution (modification permissions)

## Usage

### 1. Prepare Configuration Files

```bash
# Development environment
cd environments/dev/sample
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars
vim terraform.tfvars

# Production environment
cd environments/prod/sample
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars
vim terraform.tfvars
```

### 2. Execute Terraform

```bash
# Initialize
terraform init

# Check plan
terraform plan

# Apply
terraform apply
```

### 3. Check Output Values

```bash
terraform output
```

## Policy Management

### AWS Managed Policies

Configure in `terraform.tfvars`:

```hcl
plan_policy_arns = [
  "arn:aws:iam::aws:policy/ReadOnlyAccess"
]

apply_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/CloudFrontFullAccess"
]
```

### Custom Policies

Managed with JSON files (auto-loaded):

- Plan: `policies/plan/*.json`
- Apply: `policies/apply/*.json`

Example: `policies/plan/s3-read-only.json`
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": "*"
    }
  ]
}
```

## Adding New Projects

1. Copy environment directory:
```bash
cp -r environments/dev/sample environments/dev/new-project
cp -r environments/prod/sample environments/prod/new-project
```

2. Update configuration files:
- Default value of project_name in `variables.tf`
- Project settings in `terraform.tfvars.example`
- JSON files in `policies/` directory

## Module Dependencies

```
tfc-oidc → tfc-roles
```

- `tfc-oidc` module creates OIDC Provider
- `tfc-roles` module receives OIDC Provider ARN and creates IAM roles
- Both modules are called directly from each environment

## OIDC Configuration Details

- **URL**: https://app.terraform.io
- **Client ID**: aws.workload.identity
- **Thumbprint**: 9e99a48a9960b14926bb7f3b02e22da2b0ab7280
- **Condition**: Restricted by TFC organization/project/run_phase

## Security Principles

- **Least Privilege**: Plan is read-only, Apply has minimum necessary permissions
- **Isolation**: Independent management by environment and project
- **Conditional Access**: Restricted by TFC organization/project/run_phase
- **Module Separation**: Independence of OIDC and Role management

## Configuration Example

### terraform.tfvars
```hcl
tfc_organization = "your-tfc-organization"
tfc_project      = "sample-project"
project_name     = "sample-project"
environment      = "dev"

plan_policy_arns = [
  "arn:aws:iam::aws:policy/ReadOnlyAccess"
]

apply_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/CloudFrontFullAccess"
]
```