variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Keep same unless you want to change
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "project5-eks-cluster"
}