resource "helm_release" "hello_world" {
  name             = "default"
  chart            = "/Users/piotrwierzyk/private/netnut/charts/hello-world"
  namespace        = "default"
  create_namespace = false

  values = [yamlencode({
    ingress = {
      className = "alb"
      extraAnnotations = {
        "kubernetes.io/ingress.class"            = "alb"
        "alb.ingress.kubernetes.io/scheme"       = "internet-facing"
        "alb.ingress.kubernetes.io/target-type"  = "ip"
        "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 80}]"
      }
    }
  })]

  depends_on = [helm_release.aws_load_balancer_controller]
}

