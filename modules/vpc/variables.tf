variable "vpc_cidr" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "tags" { type = map(string) }
variable "cluster_name" {
  type    = string
  default = "tf-eks"
}
