variable "vpc_cidr_block" {
  description ="CIDR block for the vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
    description = "CIDR block for public subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
    description = "CIDR block for private subnet"
    type = string
    default = "10.0.2.0/24"
}
