output "resource_group_name" {
  description = "Resource group name"
  value       = module.network.resource_group_name
}

output "location" {
  description = "Azure location"
  value       = module.network.location
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.kubernetes.aks_cluster_name
}

output "hello_world_url" {
  description = "URL to access hello-world application"
  value       = "http://${module.kubernetes.appgw_public_ip}"
}

