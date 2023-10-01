# FIXME: name
resource "aws_ec2_client_vpn_endpoint" "example" {
  description            = "Terraform VPN Endpoint"
  server_certificate_arn = var.acm_cert_arn

  vpc_id              = var.vpc_id
  client_cidr_block   = "10.80.0.0/22"
  vpn_port            = "443"
  transport_protocol  = "udp"
  split_tunnel        = false
  self_service_portal = "enabled"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.acm_cert_arn
  }

  client_login_banner_options {
    enabled     = true
    banner_text = "This is a custom banner message for your VPN"
  }

  connection_log_options {
    enabled              = true
    cloudwatch_log_group = var.log_group_name
  }

  tags = {
    Name = "${var.workload}"
  }
}

resource "aws_ec2_client_vpn_network_association" "private_subnet_1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  subnet_id              = var.subnets[0]
}

resource "aws_ec2_client_vpn_network_association" "private_subnet_2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  subnet_id              = var.subnets[1]
}
