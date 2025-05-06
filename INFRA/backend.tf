terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "state/infra.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
