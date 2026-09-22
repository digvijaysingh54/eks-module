resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name_node
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnets_node

  scaling_config {
    desired_size = var.desire_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = "mykey"
    source_security_group_ids = [var.sg_id_node]
  }

  tags = {
    Name        = "worker-node"
    Environment = "production"
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]

}
