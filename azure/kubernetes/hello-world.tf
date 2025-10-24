resource "helm_release" "hello_world" {
  name             = "hello-world"
  chart            = "/Users/piotrwierzyk/private/netnut/charts/hello-world"
  namespace        = "default"
  create_namespace = false

  values = [yamlencode({
    ingress = {
      className = "azure-application-gateway"
      extraAnnotations = {
        "appgw.ingress.kubernetes.io/use-private-ip" = "false"
      }
    }
  })]

  depends_on = [helm_release.agic]
}

