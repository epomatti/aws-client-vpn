variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "acm_server_cert_domain_name" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_multi_az" {
  type = bool
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type      = string
  sensitive = true
}
