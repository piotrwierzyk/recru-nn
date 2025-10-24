output "resource_group_name" {
  description = "Resource group name"
  value       = module.vnet.resource_group_name
}

output "location" {
  description = "Azure location"
  value       = module.vnet.location
}


output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "aks_cluster_endpoint" {
  description = "AKS cluster endpoint"
  value       = module.aks.cluster_endpoint
  sensitive   = true
}

output "aks_cluster_ca_certificate" {
  description = "AKS cluster certificate authority"
  value       = module.aks.cluster_ca_certificate
  sensitive   = true
}

output "aks_client_certificate" {
  description = "AKS client certificate"
  value       = module.aks.client_certificate
  sensitive   = true
}

output "aks_client_key" {
  description = "AKS client key"
  value       = module.aks.client_key
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for workload identity"
  value       = module.aks.oidc_issuer_url
}


output "appgw_id" {
  description = "Application Gateway ID"
  value       = azurerm_application_gateway.main.id
}

output "appgw_name" {
  description = "Application Gateway name"
  value       = azurerm_application_gateway.main.name
}

output "appgw_public_ip" {
  description = "Application Gateway public IP"
  value       = azurerm_public_ip.appgw.ip_address
}

