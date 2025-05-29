variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "availability_zone" {
  type = string
}

variable "rds_secret_name" {
  type = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to be used by the RDS DB subnet group"
  type        = list(string)
}

variable "bastion_sg_id" {
  description = "Bastion SG ID for RDS whitelist"
  type        = string
}