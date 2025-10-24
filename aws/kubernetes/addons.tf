resource "aws_eks_addon" "coredns" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  addon_version               = "v1.11.4-eksbuild.2"
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name                = var.eks_cluster_name
  addon_version               = "v1.3.5-eksbuild.2"
  addon_name                  = "eks-pod-identity-agent"
  resolve_conflicts_on_create = "OVERWRITE"
}
