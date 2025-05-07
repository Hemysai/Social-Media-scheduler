
data "aws_secretsmanager_secret" "db_secret" {
  arn = "arn:aws:secretsmanager:us-east-1:741448954126:secret:insta-rds-password-WvLr1b"
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "insta-db-subnet-group"
  }
}

resource "aws_db_instance" "insta_rds" {
  identifier              = "insta-rds-instance"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  name                    = "instadb"
  username                = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["username"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["password"]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}
