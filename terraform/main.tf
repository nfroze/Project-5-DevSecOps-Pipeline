provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source           = "./vpc"
  vpc_cidr         = var.vpc_cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  vpc_name         = var.vpc_name
}

module "iam" {
  source       = "./iam"
  cluster_name = var.cluster_name
}

module "eks" {
  source            = "./eks"
  cluster_name      = var.cluster_name
  subnet_ids        = module.vpc.private_subnet_ids
  node_group_name   = var.node_group_name
  node_role_arn     = module.iam.node_role_arn
  desired_capacity  = var.desired_capacity
  min_capacity      = var.min_capacity
  max_capacity      = var.max_capacity
  instance_types    = var.instance_types
  ssh_key           = var.ssh_key
}