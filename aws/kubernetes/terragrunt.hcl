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
  host = "${dependency.infrastructure.outputs.eks_cluster_endpoint}"
  cluster_ca_certificate = <<INNEREOF
${dependency.infrastructure.outputs.eks_cluster_ca_certificate}
INNEREOF

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${dependency.infrastructure.outputs.eks_cluster_name}"]
    command     = "aws"
  }
}
EOF
}

generate "provider_helm" {
  path      = "provider_helm.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "helm" {
  kubernetes {
    host = "${dependency.infrastructure.outputs.eks_cluster_endpoint}"
    cluster_ca_certificate = <<INNEREOF
${dependency.infrastructure.outputs.eks_cluster_ca_certificate}
INNEREOF

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${dependency.infrastructure.outputs.eks_cluster_name}"]
      command     = "aws"
    }
  }
}
EOF
}

terraform {
  source = "."
}

inputs = {
  aws_region        = dependency.infrastructure.outputs.aws_region
  eks_cluster_name  = dependency.infrastructure.outputs.eks_cluster_name
  vpc_id            = dependency.infrastructure.outputs.vpc_id
  public_subnet_ids = dependency.infrastructure.outputs.public_subnet_ids
}

