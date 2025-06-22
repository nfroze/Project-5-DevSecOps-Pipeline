resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  metadata_options {
    instance_metadata_tags = "disabled"
  }

  tags = {
    Name = "${var.cluster_name}-node-group"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}