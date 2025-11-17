output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}


output "node_group_names" {
  value = keys(var.node_groups)
}

variable "node_groups" {
  description = "Map of node group configurations; defaults to an empty map so outputs referencing it do not fail when not provided."
  type        = map(any)
  default     = {}
}
