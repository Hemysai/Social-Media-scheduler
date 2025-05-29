variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "project" {
  type = string
}

variable "rds_secret_name" {
  type = string
  default = "insta-rds-password"
}

variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1" 
}

variable "my_ip_cidr" {
  description = "my ip address in cidr format"
  type = string
}



