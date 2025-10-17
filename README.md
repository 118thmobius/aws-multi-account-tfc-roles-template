# AWS TFC Roles プロジェクト

[English](README.en.md) | 日本語

マルチアカウント構成を取るAWS OrganizationでTerraform Cloud（TFC）を用いてAWSリソースをデプロイするためのIAMロールとOIDCプロバイダを作成するTerraformプロジェクト

## プロジェクト構成

```
aws-multi-account-tfc-roles/
├── modules/
│   ├── tfc-oidc/               # OIDCプロバイダモジュール
│   └── tfc-roles/              # IAMロールモジュール
├── environments/
│   ├── dev/                    # 開発環境
│   │   └── sample/
│   │       ├── policies/
│   │       │   ├── plan/       # Plan用カスタムポリシー
│   │       │   └── apply/      # Apply用カスタムポリシー
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── terraform.tfvars.example
│   └── prod/                   # 本番環境
│       └── sample/
└── README.md
```

## モジュール構成

### tfc-oidc モジュール
- OIDCプロバイダの作成
- Terraform Cloud用の認証基盤

### tfc-roles モジュール
- Plan用IAMロール（読み取り専用）
- Apply用IAMロール（変更権限）
- AWSマネージドポリシーとカスタムポリシーの管理

## 作成されるリソース

各環境（dev/prod）ごとに以下のリソースが作成されます：

- **OIDCプロバイダ**: Terraform Cloud用（1つ）
- **IAMロール**: Plan用とApply用（2つ）
  - Plan用: terraform plan実行用（読み取り専用）
  - Apply用: terraform apply実行用（変更権限）

## 使用方法

### 1. 設定ファイルの準備

```bash
# 開発環境
cd environments/dev/sample
cp terraform.tfvars.example terraform.tfvars
# terraform.tfvarsを編集
vim terraform.tfvars

# 本番環境
cd environments/prod/sample
cp terraform.tfvars.example terraform.tfvars
# terraform.tfvarsを編集
vim terraform.tfvars
```

### 2. Terraformの実行

```bash
# 初期化
terraform init

# プラン確認
terraform plan

# 適用
terraform apply
```

### 3. 出力値の確認

```bash
terraform output
```

## ポリシー管理

### AWSマネージドポリシー

`terraform.tfvars`で設定：

```hcl
plan_policy_arns = [
  "arn:aws:iam::aws:policy/ReadOnlyAccess"
]

apply_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/CloudFrontFullAccess"
]
```

### カスタムポリシー

JSONファイルで管理（自動読み込み）：

- Plan用: `policies/plan/*.json`
- Apply用: `policies/apply/*.json`

例：`policies/plan/s3-read-only.json`
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

## 新しいプロジェクトの追加

1. 環境ディレクトリをコピー：
```bash
cp -r environments/dev/sample environments/dev/new-project
cp -r environments/prod/sample environments/prod/new-project
```

2. 設定ファイルを更新：
- `variables.tf`のproject_nameデフォルト値
- `terraform.tfvars.example`のプロジェクト設定
- `policies/`ディレクトリ内のJSONファイル

## モジュール間の依存関係

```
tfc-oidc → tfc-roles
```

- `tfc-oidc`モジュールがOIDCプロバイダを作成
- `tfc-roles`モジュールがOIDCプロバイダARNを受け取ってIAMロールを作成
- 各環境から両モジュールを直接呼び出し

## OIDC設定詳細

- **URL**: https://app.terraform.io
- **Client ID**: aws.workload.identity
- **Thumbprint**: 9e99a48a9960b14926bb7f3b02e22da2b0ab7280
- **Condition**: TFC組織/プロジェクト/run_phaseで制限

## セキュリティ原則

- **最小権限**: Plan用は読み取り専用、Apply用は必要最小限
- **分離**: 環境別・プロジェクト別の独立管理
- **条件付きアクセス**: TFC組織/プロジェクト/run_phaseで制限
- **モジュール分離**: OIDCとRole管理の独立性

## 設定例

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