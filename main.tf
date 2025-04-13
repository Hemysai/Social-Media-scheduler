provider "aws" {
  region = "us-east-1"
}

# Variable to store the Meta Graph API Access Token
variable "meta_graph_api_access_token" {
  description = "Meta Graph API Access Token"
  type        = string
}

# Create an S3 bucket to store engagement data
resource "aws_s3_bucket" "meta_graph_s3" {
  bucket = "meta-graph-api-data"
}

# IAM Role for Lambda execution
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Assume role policy for Lambda to access the IAM role
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# IAM Policy for Lambda to allow interaction with S3 and CloudWatch
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

# Lambda Function Resource
resource "aws_lambda_function" "meta_graph_lambda" {
  function_name = "MetaGraphAPIToS3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"  # Ensure this matches the Python function handler
  runtime       = "python3.8"
  timeout       = 15
  filename      = "function.zip"  # Path to your lambda zip file

  environment {
    variables = {
      META_GRAPH_API_ACCESS_TOKEN = var.meta_graph_api_access_token  # Pass the GitHub Secrets to Lambda
      S3_BUCKET                  = aws_s3_bucket.meta_graph_s3.bucket
    }
  }

  depends_on = [aws_iam_role.lambda_role]
}
