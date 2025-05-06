variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "db_secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "rds_subnet_group_name" {
  description = "The RDS subnet group name"
  type        = string
}
