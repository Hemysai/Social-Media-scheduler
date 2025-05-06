output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnets.name   
}