variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "cluster_role_arn" {}
variable "node_role_arn" {}

resource "aws_eks_cluster" "this" {
  name     = "project5-eks-cluster"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = concat(var.private_subnet_ids, var.public_subnet_ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

  tags = {
    Name = "project5-eks-cluster"
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "project5-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = ["t3.medium"]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  tags = {
    Name = "project5-node-group"
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only
  ]
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}
