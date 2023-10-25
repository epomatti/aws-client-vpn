variable "aws_region" {
  type    = string
  default = "us-east-2"
}

### RDS ###
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

### VPC Endpoint ###
variable "vpn_endpoint_enabled" {
  type = bool
}

### OpenVPN ###
variable "openvpn_enabled" {
  type = bool
}

variable "openvpn_instance_type" {
  type = string
}
