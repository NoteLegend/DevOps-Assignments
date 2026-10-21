terraform {
  backend "local" {}
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["835582727900"]
  default_tags {
    tags = { ManagedBy = "Terraform", Project = "DevOpsAssignments", Assignment = "18" }
  }
}
