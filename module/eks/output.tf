output "eks_role_arn_output" {
  value = aws_iam_role.eks_role.arn
}

output "cluster_name_output" {
  value = aws_eks_cluster.example.name
}

output "cluster_endpoint_output" {
  value = aws_eks_cluster.example.endpoint
}

output "cluster_ca_certificate_output" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}