module "network" {
  source = "../../modules/network/aws"

  name_prefix = var.name_prefix
  aws_region  = var.aws_region
  cidr_block  = var.cidr_block
  az_count    = var.az_count
}

module "kubernetes" {
  source = "../../modules/kubernetes/aws"

  name_prefix        = var.name_prefix
  aws_region         = var.aws_region
  kubernetes_version = var.kubernetes_version
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids

  depends_on = [module.network]
}

module "hello_world" {
  source = "../../modules/applications/hello-world"

  chart_path   = "${path.module}/../../charts/hello-world"
  release_name = "hello-world"
  namespace    = "default"

  ingress_class = "alb"
  ingress_annotations = {
    "kubernetes.io/ingress.class"            = "alb"
    "alb.ingress.kubernetes.io/scheme"       = "internet-facing"
    "alb.ingress.kubernetes.io/target-type"  = "ip"
    "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 80}]"
  }

  depends_on = [module.kubernetes]
}

