terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workload              = "fastplanes"
  vpn_client_cidr_block = "10.80.0.0/22"
}

module "vpc" {
  source     = "./modules/vpc"
  aws_region = var.aws_region
  workload   = local.workload
}

module "ec2-instance" {
  source   = "./modules/ec2-instance"
  workload = local.workload
  vpc_id   = module.vpc.vpc_id
  az       = module.vpc.azs[0]
  subnet   = module.vpc.public_subnets[0]
}

module "rds_mysql" {
  source                = "./modules/mysql"
  workload              = local.workload
  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.private_subnets
  multi_az              = var.rds_multi_az
  instance_class        = var.rds_instance_class
  username              = var.rds_username
  password              = var.rds_password
  vpn_client_cidr_block = local.vpn_client_cidr_block
}

module "acm" {
  source = "./modules/acm"
}

module "cloudwatch" {
  source   = "./modules/cloudwatch"
  workload = local.workload
}

module "vpn_endpoint" {
  source           = "./modules/vpn"
  workload         = local.workload
  lient_cidr_block = local.vpn_client_cidr_block
  vpc_id           = module.vpc.vpc_id
  subnets          = module.vpc.private_subnets
  acm_cert_arn     = module.acm.server_cer_arn
  log_group_name   = module.cloudwatch.log_group_name
}
