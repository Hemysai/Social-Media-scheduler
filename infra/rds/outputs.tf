output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_name" {
  value = aws_db_instance.default.db_name
}

output "db_username" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["username"]
}

output "db_sg_id" {
  value = aws_security_group.rds.id
}
    