resource "aws_eks_cluster" "example" {
  name     = var.cluster_name
  version = var.cluster_version
  role_arn = var.eks_role_arn

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

