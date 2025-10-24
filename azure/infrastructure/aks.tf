module "aks" {
  source = "./modules/aks"

  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = module.vnet.resource_group_name
  aks_subnet_id       = module.vnet.aks_subnet_id
  vnet_id             = module.vnet.vnet_id
  kubernetes_version  = "1.30"
}

