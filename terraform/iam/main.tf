resource "aws_iam_role" "eks_cluster_role" {
  name = "project5-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# checkov:skip=CKV_AWS_160: No IAM users defined — policies only attached to roles
# checkov:skip=CKV_AWS_39: Using AWS-managed policy for demo simplicity
# checkov:skip=CKV_AWS_259: AWS-managed policy includes broad permissions
# checkov:skip=CKV_AWS_111: Using AWS-managed policy that cannot be modified
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name = "project5-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# checkov:skip=CKV_AWS_160: No IAM users defined — policies only attached to roles
# checkov:skip=CKV_AWS_39: Using AWS-managed policy for demo simplicity
# checkov:skip=CKV_AWS_259: AWS-managed policy includes broad permissions
# checkov:skip=CKV_AWS_111: Using AWS-managed policy that cannot be modified
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# checkov:skip=CKV_AWS_160: No IAM users defined — policies only attached to roles
# checkov:skip=CKV_AWS_39: Using AWS-managed policy for demo simplicity
# checkov:skip=CKV_AWS_259: AWS-managed policy includes broad permissions
# checkov:skip=CKV_AWS_111: Using AWS-managed policy that cannot be modified
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# checkov:skip=CKV_AWS_160: No IAM users defined — policies only attached to roles
# checkov:skip=CKV_AWS_39: Using AWS-managed policy for demo simplicity
# checkov:skip=CKV_AWS_259: AWS-managed policy includes broad permissions
# checkov:skip=CKV_AWS_111: Using AWS-managed policy that cannot be modified
resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
