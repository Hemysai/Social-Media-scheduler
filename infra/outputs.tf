output "rds_endpoint" {
  description = "RDS endpoint from the rds module"
  value       = module.rds.db_endpoint
}

output "bastion_ip" {
  value = module.bastion.bastion_public_ip
}