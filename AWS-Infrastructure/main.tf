terraform {
  backend "s3" {
    bucket = "project5-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }

  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

# Variables for Splunk integration
variable "splunk_hec_url" {
  description = "Splunk HEC URL"
  type        = string
}

variable "splunk_hec_token" {
  description = "Splunk HEC Token"  
  type        = string
  sensitive   = true
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
}

# IAM Module
module "iam" {
  source = "./modules/iam"
}

# EKS Module
module "eks" {
  source             = "./modules/eks"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn
}

# Security Module (GuardDuty + CloudWatch to Splunk)
module "security" {
  source = "./modules/security"
  
  eks_cluster_name = module.eks.cluster_name
  splunk_hec_url   = var.splunk_hec_url
  splunk_hec_token = var.splunk_hec_token
  
  depends_on = [module.eks]
}
