provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI for us-east-1
  instance_type = "t2.micro"

  tags = {
    Name = "GitHubEC2"
  }
}
