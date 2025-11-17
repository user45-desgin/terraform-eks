# Uncomment & fill values to enable remote state
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-bucket"
#     key            = "terraform-eks/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
