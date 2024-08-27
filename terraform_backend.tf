# Configure Terraform backend as s3 and use dynamodb table 
terraform {
  backend "s3" {
    bucket         = "kkp-personal-terraform"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "kkp-personal-terraform-locks"
  }
}
