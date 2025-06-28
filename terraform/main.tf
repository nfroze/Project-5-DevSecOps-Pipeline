provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"

  vpc_cidr = var.vpc_cidr
  azs      = var.azs
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source = "./eks"

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