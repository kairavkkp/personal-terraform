# Local-exec provisioner to build and package Go code
resource "null_resource" "build_lambda" {
  provisioner "local-exec" {
    command = <<EOT
      GOOS=linux GOARCH=amd64 go build -o bootstrap main.go
      zip start_analyze_expense.zip bootstrap
    EOT
    working_dir = "${path.module}/scripts"
  }

  triggers = {
    go_source = "${file("${path.module}/scripts/main.go")}"
  }
}

# Lambda function
resource "aws_lambda_function" "start_analyze_expense" {
  filename         = "${path.module}/scripts/start_analyze_expense.zip"  # Ensure the path is correct
  function_name    = "start-analyze-expense"
  role             = var.IAM_ROLE_ARN
  handler          = "bootstrap"  # Handler should match the compiled binary name
  source_code_hash = filebase64sha256("${path.module}/scripts/start_analyze_expense.zip")
  runtime          = "go1.x"
  depends_on       = [null_resource.build_lambda]
}