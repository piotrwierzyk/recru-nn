provider "azurerm" {
  features {}
  subscription_id = "9eb5e723-105f-4b88-a99e-d3bdd66f3f4d"
}

provider "kubernetes" {
  host                   = module.kubernetes.aks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.kubernetes.aks_cluster_ca_certificate)
  client_certificate     = base64decode(module.kubernetes.aks_client_certificate)
  client_key             = base64decode(module.kubernetes.aks_client_key)
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.aks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.kubernetes.aks_cluster_ca_certificate)
    client_certificate     = base64decode(module.kubernetes.aks_client_certificate)
    client_key             = base64decode(module.kubernetes.aks_client_key)
  }
}

