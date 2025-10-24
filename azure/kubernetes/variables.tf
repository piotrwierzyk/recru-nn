variable "location" {
  description = "Azure region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL for workload identity"
  type        = string
}

variable "appgw_id" {
  description = "Application Gateway ID"
  type        = string
}

variable "appgw_name" {
  description = "Application Gateway name"
  type        = string
}

variable "appgw_public_ip" {
  description = "Application Gateway public IP address"
  type        = string
}

