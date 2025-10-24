output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "EKS cluster certificate authority"
  value       = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
}

output "alb_controller_namespace" {
  description = "ALB controller namespace"
  value       = kubernetes_namespace.aws_load_balancer_controller.metadata[0].name
}

