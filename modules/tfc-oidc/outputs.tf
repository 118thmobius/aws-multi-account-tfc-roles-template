output "oidc_provider_arn" {
  description = "OIDCプロバイダARN"
  value       = aws_iam_openid_connect_provider.tfc_provider.arn
}