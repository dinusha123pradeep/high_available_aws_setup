terraform {
  cloud {
    organization = "marathunga"
    workspaces {
      name = "high_available_aws_setup"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.35.0"
    }
  }

  required_version = ">=1.3.0"
}