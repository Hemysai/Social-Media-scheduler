resource "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH from personal IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0953476d60561c955" 
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  security_groups = [aws_security_group.bastion.id]
  tags = {
    Name = "Bastion Host"
  }
}
