module "vpc" {
  source     = "./vpc"
  vpc_cidr   = var.vpc_cidr
  azs        = var.azs
  project    = var.project
}

module "rds" {
  source            = "./rds"
  project           = var.project
  vpc_id            = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  subnet_ids        = module.vpc.public_subnet_ids
  availability_zone = var.azs[0]
  rds_secret_name   = var.rds_secret_name
}


