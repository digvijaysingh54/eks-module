resource "aws_eks_cluster" "example" {
  name     = var.cluster_name
  version = var.cluster_version
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnets
    security_group_ids = [var.sg_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

