resource "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allows SSH from personal IP"
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

resource "aws_iam_role" "bastion_role" {
  name= "bastion-iam-role"

  assume_role_policy = jsonencode({
    version = "2012-10-17"
    statement = [{
      Effect = "Allow"
      principal = {
        service = "ec2.amazon.com"
      }
      Action = "sts.Assumerole"
    }]
  })
}

resource "aws_iam_policy" "bastion_secrets_policy" {
  name = "bastion-secrets-read-policy"

  policy = jsonencode({
    version = "2012-10-17"
    statement = [
      {
        Effect = "Allow"
        Action = [
          "secretmanager:GetSecretValue"
        ]
        resource = var.secrets_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.bastion_secrets_policy.arn
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "bastion_instance_profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_instance" "bastion" {
  ami           = "ami-0953476d60561c955" 
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  security_groups = [aws_security_group.bastion.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_instance_profile.name

  tags = {
    Name = "Bastion Host"
  }
}
