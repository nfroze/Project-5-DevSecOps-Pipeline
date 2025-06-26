variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for EKS nodes"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "max_capacity" {
  type        = number
  description = "Maximum number of worker nodes"
}

variable "min_capacity" {
  type        = number
  description = "Minimum number of worker nodes"
}

variable "instance_types" {
  type        = list(string)
  description = "List of EC2 instance types for the node group"
}

variable "ami_type" {
  type        = string
  description = "AMI type for EKS node group"
}

variable "ssh_key" {
  type        = string
  description = "SSH key name for EC2 nodes"
}

variable "source_security_group_ids" {
  type        = list(string)
  description = "Security group IDs allowed to connect via SSH"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN used for encrypting Kubernetes secrets"
}