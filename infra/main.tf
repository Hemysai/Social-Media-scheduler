module "vpc" {
  source     = "./vpc"
  vpc_cidr   = var.vpc_cidr
  azs        = var.azs
  project    = var.project
}
