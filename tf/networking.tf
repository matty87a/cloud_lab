module "primary_vpc" {
  source = "./modules/networking"

  vpc_cidr           = var.primary_networking.vpc_cidr
  name               = var.primary_networking.vpc_name
  azs                = [for subnet in var.primary_networking.public_subnets : subnet.availability_zone]
  private_subnets    = [for subnet in var.primary_networking.private_subnets : subnet.cidr_block]
  public_subnets     = [for subnet in var.primary_networking.public_subnets : subnet.cidr_block]
  enable_nat_gateway = var.primary_networking.enable_nat_gateway
  tags               = var.primary_networking.tags
}

module "dr_vpc" {
  source = "./modules/networking"
  providers = {
    aws = aws.dr
  }

  vpc_cidr           = var.dr_networking.vpc_cidr
  name               = var.dr_networking.vpc_name
  azs                = [for subnet in var.dr_networking.public_subnets : subnet.availability_zone]
  private_subnets    = [for subnet in var.dr_networking.private_subnets : subnet.cidr_block]
  public_subnets     = [for subnet in var.dr_networking.public_subnets : subnet.cidr_block]
  enable_nat_gateway = var.dr_networking.enable_nat_gateway
  tags               = var.dr_networking.tags
}
