data "aws_ami" "eks_default" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-*-*"]
  }

  owners = ["602401143452"] # Amazon
}

resource "aws_launch_template" "eks_node_template" {
  name_prefix = "eks-node-template-"
  image_id    = data.aws_ami.eks_default.id

  metadata_options {
    http_tokens = "required" # Enforce IMDSv2
  }
}

# checkov:skip=CKV_AWS_117: Public access disabled — no CIDR block needed
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = false
    endpoint_private_access = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = var.kms_key_arn
    }
  }

  tags = {
    Name = var.cluster_name
  }

  depends_on = [
    var.cluster_role_arn
  ]
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = var.instance_types
  ami_type       = var.ami_type

  launch_template {
    id      = aws_launch_template.eks_node_template.id
    version = "$Latest"
  }

  remote_access {
    ec2_ssh_key               = var.ssh_key
    source_security_group_ids = var.source_security_group_ids
  }

  tags = {
    Name = var.node_group_name
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}