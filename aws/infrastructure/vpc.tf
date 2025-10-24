module "vpc" {
  source = "./modules/vpc"

  name_prefix = var.name_prefix
  cidr_block  = var.cidr_block
  az_count    = var.az_count
}

