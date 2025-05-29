variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "my_ip_cidr" {
  type        = string
  description = "Your IP CIDR for SSH access"
}
