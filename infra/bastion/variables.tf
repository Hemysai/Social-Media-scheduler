variable "project" {
  type        = string
  description = "Project name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to launch bastion"
}

variable "public_subnet" {
  type        = string
  description = "Public subnet ID for bastion instance"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to launch bastion"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "my_ip_cidr" {
  type        = string
  description = "Your IP CIDR block for SSH access"
}
