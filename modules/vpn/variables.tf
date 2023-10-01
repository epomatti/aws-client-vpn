variable "workload" {
  type = string
}

variable "lient_cidr_block" {
  type = string
}

variable "acm_cert_arn" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}
