variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS nodes"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and node group"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired node group capacity"
  type        = number
}

variable "min_capacity" {
  description = "Minimum node group capacity"
  type        = number
}

variable "max_capacity" {
  description = "Maximum node group capacity"
  type        = number
}

variable "instance_types" {
  description = "Instance types for the node group"
  type        = list(string)
}

variable "ssh_key" {
  description = "SSH key name for EC2 access"
  type        = string
}

variable "source_security_group_ids" {
  description = "List of security group IDs allowed to access nodes"
  type        = list(string)
}