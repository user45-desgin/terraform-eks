output "cluster_id" {
  value = aws_eks_cluster.this.id
}


output "cluster_ca_certificate" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_name" {
  value = aws_eks_node_group.default.node_group_name
}