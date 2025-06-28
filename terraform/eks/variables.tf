variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of nodes"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of nodes"
  type        = number
}

variable "instance_types" {
  description = "List of instance types"
  type        = list(string)
}