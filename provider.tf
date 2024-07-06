terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.40.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "kairav-pithadia-personal"
}
