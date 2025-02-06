module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source   = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source           = "./modules/ec2"
  AWS_AMIS         = var.AWS_AMIS
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
  security_group_id = module.security_group.ec2_sg_id
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}
module "s3" {
  source = "./modules/s3"
}

module "rds" {
  source = "./modules/rds"
  security_group_id = module.security_group.rds_sg_id
  dbpassword = var.dbpassword
  dbusername = var.dbusername
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids 
}
