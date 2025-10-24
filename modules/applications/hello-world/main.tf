resource "helm_release" "hello_world" {
  name             = var.release_name
  chart            = var.chart_path
  namespace        = var.namespace
  create_namespace = false

  force_update    = true
  recreate_pods   = true
  cleanup_on_fail = true

  values = [yamlencode({
    ingress = {
      className        = var.ingress_class
      extraAnnotations = var.ingress_annotations
    }
  })]
}

