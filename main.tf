module "security_group" {
  source   = "./modules/security_group"
  map_list = var.map_list
  
}

module "ec2" {
  source           = "./modules/ec2"
  AWS_AMIS         = var.AWS_AMIS
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
  map_list         = var.map_list
  security_group_id = module.security_group.security_group_id
}
module "s3" {
  source = "./modules/s3"
}

module "rds" {
  source = "./modules/rds"
  security_group_id = module.security_group.security_group_id
  dbpassword = var.dbpassword
  dbusername = var.dbusername
}
