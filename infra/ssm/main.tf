resource "aws_security_group" "ec2" {
  name        = "${var.project}-ec2-sg"
  description = "Security group for EC2 to access RDS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-ec2-sg"
  }
}

resource "aws_security_group_rule" "allow_bastion_to_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2.id
  source_security_group_id = var.bastion_sg_id
  description              = "Allow SSH from Bastion to SSM EC2"
}

resource "aws_iam_role" "ssm_role" {
  name = "${var.project}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.project}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_instance" "ssm_ec2" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = false

  tags = {
    Name = "${var.project}-ssm-ec2"
  }
}
