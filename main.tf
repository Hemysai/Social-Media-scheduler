provider "aws" {
  region = "us-east-1"
}

variable "meta_graph_api_access_token" {
  description = "Meta Graph API Access Token"
  type        = string
}

resource "aws_lambda_function" "meta_graph_lambda" {
  function_name = "MetaGraphAPIToS3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 15
  filename      = "function.zip"  # Path to your lambda zip file

  environment {
    variables = {
      META_GRAPH_API_ACCESS_TOKEN = var.meta_graph_api_access_token  # Environment variable from GitHub secrets
      S3_BUCKET                  = aws_s3_bucket.meta_graph_s3.bucket
    }
  }

  depends_on = [aws_iam_role.lambda_role]
}

resource "aws_s3_bucket" "meta_graph_s3" {
  bucket = "meta-graph-api-data"
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:PutObject"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.meta_graph_s3.arn}/*"
      },
      {
        Action   = ["logs:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
