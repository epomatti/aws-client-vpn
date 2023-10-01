# resource "aws_acm_certificate" "server" {
#   domain_name       = var.server_cert_domain_name
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "tls_private_key" "server" {
#   algorithm = "RSA"
# }

# resource "tls_self_signed_cert" "server" {
#   key_algorithm   = "RSA"
#   private_key_pem = tls_private_key.server.private_key_pem

#   subject {
#     common_name  = var.server_cert_domain_name
#     organization = "ACME Examples, Inc"
#   }

#   validity_period_hours = 12

#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]
# }

locals {
  certs_rel_path = "${path.module}/../../certs"

  private_key       = file("${local.certs_rel_path}/server.key")
  certificate_body  = file("${local.certs_rel_path}/server.crt")
  certificate_chain = file("${local.certs_rel_path}/ca.crt")
}

resource "aws_acm_certificate" "server" {
  private_key       = local.private_key
  certificate_body  = local.certificate_body
  certificate_chain = local.certificate_chain
}

# aws acm import-certificate --certificate fileb://server.crt --certificate-chain fileb://ca.crt
# aws acm import-certificate --certificate fileb://client1.domain.tld.crt --private-key fileb://client1.domain.tld.key --certificate-chain fileb://ca.crt
