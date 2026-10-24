module "vpc" {
  source                 = "./modules/vpc"
  cidr_range             = var.vpc_cidr_range
  cidr_range_public_azs  = var.cidr_range_public_azs
  cidr_range_private_azs = var.cidr_range_private_azs
}