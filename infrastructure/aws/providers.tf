provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "${var.name_prefix}-recru-nn"
      ManagedBy = "terraform"
    }
  }
}

provider "kubernetes" {
  host                   = module.kubernetes.eks_cluster_endpoint
  cluster_ca_certificate = module.kubernetes.eks_cluster_ca_certificate

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.kubernetes.eks_cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.eks_cluster_endpoint
    cluster_ca_certificate = module.kubernetes.eks_cluster_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.kubernetes.eks_cluster_name]
      command     = "aws"
    }
  }
}

