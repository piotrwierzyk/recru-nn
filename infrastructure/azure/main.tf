module "network" {
  source = "../../modules/network/azure"

  name_prefix   = var.name_prefix
  location      = var.location
  address_space = var.address_space
}

module "kubernetes" {
  source = "../../modules/kubernetes/azure"

  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = module.network.resource_group_name
  aks_subnet_id       = module.network.aks_subnet_id
  vnet_id             = module.network.vnet_id
  appgw_subnet_id     = module.network.appgw_subnet_id
  kubernetes_version  = var.kubernetes_version

  depends_on = [module.network]
}

module "hello_world" {
  source = "../../modules/applications/hello-world"

  chart_path   = "${path.module}/../../charts/hello-world"
  release_name = "hello-world"
  namespace    = "default"

  ingress_class = "azure-application-gateway"
  ingress_annotations = {
    "appgw.ingress.kubernetes.io/use-private-ip" = "false"
  }

  depends_on = [module.kubernetes]
}

