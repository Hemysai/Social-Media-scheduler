
provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./network"
}

module "rds" {
  source = "./rds"
}
