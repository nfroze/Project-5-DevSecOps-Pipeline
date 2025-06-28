variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "node_group_name" {
  type        = string
  description = "Name of the node group"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "min_capacity" {
  type        = number
  description = "Minimum number of worker nodes"
}

variable "max_capacity" {
  type        = number
  description = "Maximum number of worker nodes"
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for the node group"
}

variable "ssh_key" {
  type        = string
  description = "SSH key name for accessing nodes"
}