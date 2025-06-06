output "rds_endpoint" {
  description = "RDS endpoint from the rds module"
  value       = module.rds.db_endpoint
}

