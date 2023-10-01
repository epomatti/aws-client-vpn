# resource "aws_acm_certificate" "server" {
#   domain_name       = var.server_cert_domain_name
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "server" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = var.server_cert_domain_name
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server" {
  private_key      = tls_private_key.server.private_key_pem
  certificate_body = tls_self_signed_cert.server.cert_pem
}
