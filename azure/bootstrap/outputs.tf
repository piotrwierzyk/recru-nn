output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.terraform_state.name
}

output "storage_account_name" {
  description = "Storage account name"
  value       = azurerm_storage_account.terraform_state.name
}

output "container_name" {
  description = "Container name"
  value       = azurerm_storage_container.terraform_state.name
}

output "location" {
  description = "Azure region"
  value       = var.location
}

