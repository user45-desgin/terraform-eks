variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "manage_aws_auth" {
  type    = bool
  default = true
}

variable "map_users" {
  type    = list(any)
  default = []
}

variable "cluster_role_dependencies" {
  type    = list(any)
  default = []
}
