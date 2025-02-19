provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-awesome-bucket"  # Replace with a globally unique bucket name
  # Remove the deprecated ACL argument here
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.bucket
  acl    = "private"  # Set ACL to private
}

# Optional: you can add other resources such as IAM roles, policies, etc., below
