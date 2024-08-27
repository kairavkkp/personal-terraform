module "textract_tutorial" {
  source               = "./textract_tutorial"
  PERSONAL_BUCKET_NAME = aws_s3_bucket.kkp_personal_terraform.bucket
}
