variable "db_secret_name" {
  type = string
}

variable "rds_subnet_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

