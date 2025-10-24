output "release_name" {
  description = "Helm release name"
  value       = helm_release.hello_world.name
}

output "namespace" {
  description = "Kubernetes namespace"
  value       = helm_release.hello_world.namespace
}

