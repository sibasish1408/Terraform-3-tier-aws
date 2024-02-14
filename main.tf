provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "./modules/vpc"
  region  = var.region
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

module "ecs" {
  source  = "./modules/ecs"
  region  = var.region
  vpc_id  = module.vpc.vpc_id
}

module "elb" {
  source  = "./modules/elb"
  region  = var.region
  vpc_id  = module.vpc.vpc_id
  ecs_service_name = module.ecs.service_name
  elb_name = var.elb_name
}

module "security_groups" {
  source  = "./modules/security_groups"
  region  = var.region
  vpc_id  = module.vpc.vpc_id
  ecs_cluster_name = module.ecs.cluster_name
  elb_security_group_id = module.elb.security_group_id
}

module "nat_gateway" {
  source  = "./modules/nat_gateway"
  region  = var.region
  vpc_id  = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}
