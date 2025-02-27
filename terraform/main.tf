module "networking" {
  source = "./networking"
  # (You can override networking variables here if needed.)
}

module "rds" {
  source             = "./rds"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
}

module "bastion" {
  source           = "./bastion"
  vpc_id           = module.networking.vpc_id
  public_subnet_id = module.networking.public_subnet_ids[0]  # Use the first public subnet
  key_name         = var.key_name
  ami_id           = var.ami_id
}
