module "vpc" {
  source  = "./vpc"
  vpc_cidr = var.vpc_cidr
  azs     = var.azs
  project = var.project
}

module "rds" {
  source            = "./rds"
  project           = var.project
  vpc_id            = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  subnet_ids        = module.vpc.public_subnet_ids
  availability_zone = var.azs[0]
  rds_secret_name   = var.rds_secret_name
  vpc_cidr          = var.vpc_cidr  
  ec2_sg_id         = module.ssm.ec2_security_group_id
}

module "ssm" {
  source                = "./ssm"
  project               = var.project
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  vpc_cidr              = var.vpc_cidr
  region                = var.region
  subnet_id             = module.vpc.private_subnet_ids[0]
  bastion_sg_id         = module.bastion.bastion_sg_id
  ami_id                = "ami-0c2b8ca1dad447f8a"
  private_route_table_ids = module.vpc.private_route_table_ids
}

module "s3" {
  source  = "./s3"
  project = var.project
}

module "bastion" {
  source        = "./bastion"
  project       = var.project
  vpc_id        = module.vpc.vpc_id
  public_subnet = module.vpc.public_subnet_ids[0]
  ami_id        = "ami-0c2b8ca1dad447f8a"
  key_name      = var.key_name
  my_ip_cidr    = var.my_ip_cidr
}
