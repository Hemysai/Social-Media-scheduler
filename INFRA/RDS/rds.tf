data "aws_secretsmanager_secret_version" "db_creds" {
  secret_id = var.db_secret_name
}

locals {
  db_secrets = jsondecode(data.aws_secretsmanager_secret_version.db_creds.secret_string)
}

resource "aws_db_subnet_group" "main" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier              = "insta-rds-postgres"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = local.db_secrets["username"]
  password                = local.db_secrets["password"]
  db_name                 = "instadb"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  publicly_accessible     = false
  skip_final_snapshot     = true
}
