resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url = "https://app.terraform.io"
  client_id_list = ["aws.workload.identity"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  tags = {
    Name        = "${var.project_name}-${var.environment}-tfc-oidc"
    Project     = var.project_name
    Environment = var.environment
  }
}