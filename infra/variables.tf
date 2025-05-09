variable "region" {
  type    = string
  default = "us-east-1"
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
