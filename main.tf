provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-awesome-bucket-${random_integer.suffix.result}" # Generates a unique bucket name
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.bucket
  acl    = "private"
}

# Generates a random number to ensure uniqueness
resource "random_integer" "suffix" {
  min = 100000
  max = 999999
}
