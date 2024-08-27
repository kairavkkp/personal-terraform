module "start_analyze_expense_lambda" {
  source               = "./start_analyze_expense_lambda"
  PERSONAL_BUCKET_NAME = var.PERSONAL_BUCKET_NAME
  IAM_ROLE_ARN         = aws_iam_role.textract_tutorial.arn
}
