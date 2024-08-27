
resource "aws_iam_role" "textract_tutorial" {
  name = "textract-tutorial"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sts:AssumeRole",
        ],
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "textract.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "sns.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "sqs.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

}

resource "aws_iam_policy" "textract_tutorial" {
  name        = "textract_tutorial"
  description = "Policy for Textract Tutorial."
  policy      = data.aws_iam_policy_document.textract_tutorial.json
}

data "aws_iam_policy_document" "textract_tutorial" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.kkp_textract_tutorial.arn}",
      "${aws_s3_bucket.kkp_textract_tutorial.arn}/*",
    ]
  }

  statement {
    actions = [
      "textract:StartDocumentTextDetection",
      "textract:GetDocumentTextDetection",
      "textract:AnalyzeDocument",
      "textract:StartExpenseAnalysis",
      "textract:GetExpenseAnalysis",
      "textract:StartDocumentAnalysis",
      "textract:GetDocumentAnalysis",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "sns:Publish",
      "sns:GetTopicAttributes",
      "sns:Subscribe"
    ]
    resources = [
      "${aws_sns_topic.analyze_expense.arn}",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "textract_tutorial" {
  role       = aws_iam_role.textract_tutorial.name
  policy_arn = aws_iam_policy.textract_tutorial.arn
}
