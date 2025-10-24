module "vnet" {
  source = "./modules/vnet"

  name_prefix   = var.name_prefix
  location      = var.location
  address_space = var.address_space
}

