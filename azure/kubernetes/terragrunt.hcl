include "root" {
  path   = "../terragrunt.hcl"
  expose = true
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}

generate "provider_kubernetes" {
  path      = "provider_kubernetes.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "kubernetes" {
  host                   = "${dependency.infrastructure.outputs.aks_cluster_endpoint}"
  client_certificate     = base64decode("${dependency.infrastructure.outputs.aks_client_certificate}")
  client_key             = base64decode("${dependency.infrastructure.outputs.aks_client_key}")
  cluster_ca_certificate = base64decode("${dependency.infrastructure.outputs.aks_cluster_ca_certificate}")
}
EOF
}

generate "provider_helm" {
  path      = "provider_helm.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "helm" {
  kubernetes {
    host                   = "${dependency.infrastructure.outputs.aks_cluster_endpoint}"
    client_certificate     = base64decode("${dependency.infrastructure.outputs.aks_client_certificate}")
    client_key             = base64decode("${dependency.infrastructure.outputs.aks_client_key}")
    cluster_ca_certificate = base64decode("${dependency.infrastructure.outputs.aks_cluster_ca_certificate}")
  }
}
EOF
}

terraform {
  source = "."
}

inputs = {
  name_prefix         = "pw"
  resource_group_name = dependency.infrastructure.outputs.resource_group_name
  location            = dependency.infrastructure.outputs.location
  aks_cluster_name    = dependency.infrastructure.outputs.aks_cluster_name
  oidc_issuer_url     = dependency.infrastructure.outputs.oidc_issuer_url
  appgw_id            = dependency.infrastructure.outputs.appgw_id
  appgw_name          = dependency.infrastructure.outputs.appgw_name
  appgw_public_ip     = dependency.infrastructure.outputs.appgw_public_ip
}

