resource "kubernetes_namespace" "aws_load_balancer_controller" {
  metadata {
    name = "aws-load-balancer-controller"
  }
}

data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "pods.eks.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
  }
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name        = "${var.name_prefix}-alb-controller-policy"
  description = "Policy for EKS AWS Load Balancer Controller"
  policy      = file("${path.module}/aws_load_balancer_controller_policy.json")
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = "${var.name_prefix}-alb-controller-role"
  description        = "Role for EKS AWS Load Balancer Controller"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attachment" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

resource "aws_eks_pod_identity_association" "aws_load_balancer_controller" {
  cluster_name = aws_eks_cluster.main.name
  role_arn     = aws_iam_role.aws_load_balancer_controller.arn

  namespace       = kubernetes_namespace.aws_load_balancer_controller.metadata[0].name
  service_account = "aws-load-balancer-controller"
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  namespace = kubernetes_namespace.aws_load_balancer_controller.metadata[0].name

  atomic  = true
  timeout = 120

  values = [yamlencode({
    clusterName       = aws_eks_cluster.main.name
    vpcId             = var.vpc_id
    defaultTargetType = "ip"

    region  = var.aws_region
    subnets = var.public_subnet_ids

    serviceAccount = {
      name = "aws-load-balancer-controller"
    }

    replicaCount = 1

    controllerConfig = {
      featureGates = {
        SubnetsClusterTagCheck = false
      }
    }
  })]

  depends_on = [
    aws_eks_pod_identity_association.aws_load_balancer_controller,
  ]
}

