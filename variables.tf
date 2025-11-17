###############################################
# VPC Variables
###############################################

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

###############################################
# EKS Variables
###############################################

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.30"
}

variable "aws_account_id" {
  type = string
}

variable "jenkins_user" {
  type = string
}



