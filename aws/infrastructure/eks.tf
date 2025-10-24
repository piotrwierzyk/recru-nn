module "eks" {
  source = "./modules/eks"

  name_prefix        = var.name_prefix
  region             = var.aws_region
  kubernetes_version = "1.34"
  private_subnet_ids = module.vpc.private_subnet_ids
}

