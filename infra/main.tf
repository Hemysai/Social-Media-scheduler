
# main.tf - main entry point for Terraform configuration
provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./network"
}

module "rds" {
  source = "./rds"
  db_username = "insta_admin"
  db_password = module.rds_password.secret
}

resource "aws_secretsmanager_secret" "insta_rds_password" {
  name = "insta-rds-password"
}

resource "aws_secretsmanager_secret_version" "insta_rds_password_version" {
  secret_id     = aws_secretsmanager_secret.insta_rds_password.id
  secret_string = "{"username":"insta_admin", "password":"Meethatha@22"}"
}

output "rds_username" {
  value = module.rds.db_username
}

output "rds_password" {
  value = module.rds.db_password
}
