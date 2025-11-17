###############################################
# AWS Provider
###############################################


# Declare node_desired variable if not declared elsewhere
variable "node_desired" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

# Minimum number of nodes in the node group
variable "node_min" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

# Maximum number of nodes in the node group
variable "node_max" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 3
}

# Instance types for worker nodes
variable "node_instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

###############################################
# VPC Module
###############################################
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = {
    Name = var.cluster_name
  }
}

###############################################
# IAM Module (Cluster Role + Node Role)
###############################################
module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
}

###############################################
# EKS Module
###############################################
module "eks" {
  source = "./modules/eks"

  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version

  private_subnets     = module.vpc.private_subnets
  public_subnets      = module.vpc.public_subnets

  cluster_role_arn    = module.iam.cluster_role_arn
  node_role_arn       = module.iam.node_role_arn

  node_desired_size   = var.node_desired
  node_min_size       = var.node_min
  node_max_size       = var.node_max
  node_instance_types = var.node_instance_types
}

###############################################
# DATA SOURCES FOR KUBERNETES PROVIDER
###############################################
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}


###############################################
# KUBERNETES PROVIDER (After EKS Exists)
###############################################



provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}




###############################################
# Outputs
###############################################
output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
