terraform {
  backend "s3" {
    bucket         = "ankit-bucket-for-state-locking"
    key            = "global/terraform.tfstate"              
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
}
