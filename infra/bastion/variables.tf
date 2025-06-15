variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "project" {
  type    = string
  default = "social-app"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "my_ip_cidr" {
  description = "my ip address in cidr format"
  type = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "key_name" {
    description = "key vakue for ec2"
    type = string
}