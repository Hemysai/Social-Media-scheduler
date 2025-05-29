resource "aws_security_group" "bastion" {
  name = "baastion-sg"
  description = "allow ssh access"
  vpc_id = var.vpc_id

  ingress = "SSH from local"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.my_ip]
}

resource "aws_instance" "bastion" {
  ami = ami-0c02fb55956c7d316
  instance_type = "t3-micro"
  subnet_id = module.vpc.public_subnet
}

72.138.140.114