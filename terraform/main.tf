provider "aws" {
  region = var.aws_region
}

# Required for VPC IAM policy to scope log group ARNs correctly
data "aws_caller_identity" "current" {}

module "vpc" {
  source          = "./vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  aws_region      = var.aws_region
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_name        = var.vpc_name
  kms_key_arn     = var.kms_key_arn
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source                    = "./eks"

  cluster_name              = var.cluster_name
  cluster_role_arn          = module.iam.eks_cluster_role_arn
  subnet_ids                = module.vpc.private_subnet_ids

  node_group_name           = var.node_group_name
  node_role_arn             = var.node_role_arn
  desired_capacity          = var.desired_capacity
  min_capacity              = var.min_capacity
  max_capacity              = var.max_capacity
  instance_types            = var.instance_types
  ami_type                  = var.ami_type
  ssh_key                   = var.ssh_key
  source_security_group_ids = var.source_security_group_ids
  kms_key_arn               = var.kms_key_arn
}