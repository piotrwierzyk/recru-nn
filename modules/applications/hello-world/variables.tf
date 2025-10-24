variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "hello-world"
}

variable "chart_path" {
  description = "Path to the hello-world chart"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "default"
}

variable "ingress_class" {
  description = "Ingress class name (e.g., alb or azure-application-gateway)"
  type        = string
}

variable "ingress_annotations" {
  description = "Additional annotations for the ingress"
  type        = map(string)
  default     = {}
}

