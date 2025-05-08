
module "rds_password" {
  source = "terraform-aws-modules/rds/aws//modules/db-password"

  db_password = "{"username":"insta_admin", "password":"Meethatha@22"}"
}

resource "aws_db_instance" "main" {
  allocated_storage = 20
  storage_type      = "gp2"
  db_instance_class = "db.t2.micro"
  engine            = "mysql"
  engine_version    = "8.0"
  name              = "instadatabase"
  username          = "insta_admin"
  password          = module.rds_password.secret
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]
  multi_az          = false
  publicly_accessible = false

  tags = {
    Name = "main-rds-instance"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.main.id]

  tags = {
    Name = "main-db-subnet-group"
  }
}
