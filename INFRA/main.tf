module "network" {
  source               = "./network"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
}

module "rds" {
  source                  = "./rds"
  db_secret_name          = var.db_secret_name
  rds_subnet_group_name   = var.rds_subnet_group_name
  subnet_ids = [module.network.private_subnet_id]
}
