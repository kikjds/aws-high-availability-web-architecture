module "vpc" {
  source                 = "./modules/vpc"
  cidr_range             = var.vpc_cidr_range
  cidr_range_public_azs  = var.cidr_range_public_azs
  cidr_range_private_azs = var.cidr_range_private_azs
}

module "compute" {
  source             = "./modules/compute"
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  depends_on         = [module.vpc]
}