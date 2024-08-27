# S3 bucket that store Terraform State file
resource "aws_s3_bucket" "kkp_personal_terraform" {
  bucket = "kkp-personal-terraform"
}

resource "aws_s3_bucket_versioning" "kkp_personal_terraform_versioning" {
  bucket = aws_s3_bucket.kkp_personal_terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "kkp_personal_terraform_encryption" {
  bucket = aws_s3_bucket.kkp_personal_terraform.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "kkp_personal_terraform_policy" {
  bucket = aws_s3_bucket.kkp_personal_terraform.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "${aws_s3_bucket.kkp_personal_terraform.arn}/*",
          aws_s3_bucket.kkp_personal_terraform.arn,
        ],
      },
    ],
  })
}



# dynamodb table that maintain locking on Terraform State file
resource "aws_dynamodb_table" "kkp_terraform_locks" {
  hash_key     = "LockID"
  name         = "kkp-personal-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Create Policy to Allow users use DynamoDB Table for Terraform Lock
resource "aws_iam_policy" "DynamoDBTerraformLockTable" {
  name        = "KkpDynamoDBTerraformLockTable"
  path        = "/"
  description = "Grant access to Terraform lock table on DynamoDB for each one policy"


  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ListAndDescribe",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:List*",
          "dynamodb:DescribeReservedCapacity*",
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeTimeToLive"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "SpecificTable",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:BatchGet*",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTable",
          "dynamodb:Get*",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWrite*",
          "dynamodb:CreateTable",
          "dynamodb:Delete*",
          "dynamodb:Update*",
          "dynamodb:PutItem"
        ],
        "Resource" : "${aws_dynamodb_table.kkp_terraform_locks.arn}"
      }
    ]
    }
  )
}
