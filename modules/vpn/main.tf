resource "aws_ec2_client_vpn_endpoint" "example" {
  description            = "Terraform VPN Endpoint"
  server_certificate_arn = var.acm_cert_arn
  client_cidr_block      = "10.80.0.0/22"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.acm_cert_arn
  }

  connection_log_options {
    enabled              = true
    cloudwatch_log_group = var.log_group_name
    # cloudwatch_log_stream = aws_cloudwatch_log_stream.ls.name
  }
}
