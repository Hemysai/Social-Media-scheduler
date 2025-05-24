# infra/backend.tf

terraform {
  backend "s3" {
    bucket         = "terraform-state-hemanth"
    key            = "social-media-scheduler/infra.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
