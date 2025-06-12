resource "aws_s3_bucket" "schema_bucket" {
  bucket = "${var.project}-schema-bucket"
  force_destroy = true

  tags = {
    Name = "${var.project}-schema-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.schema_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
