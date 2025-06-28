variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "devsecops-eks-demo"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "devsecops-eks-nodes"
}

variable "node_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
  default     = ""
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ami_type" {
  description = "Type of AMI to use for the node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "ssh_key" {
  description = "Name of the EC2 Key Pair to enable SSH access"
  type        = string
  default     = ""
}

variable "source_security_group_ids" {
  description = "List of source security group IDs for SSH access"
  type        = list(string)
  default     = []
}

variable "kms_key_arn" {
  description = "KMS key ARN for encrypting secrets in EKS"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "devsecops-vpc"
}