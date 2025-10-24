variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name for Terraform state"
  type        = string
  default     = "rg-pw-terraform-state-netnut"
}

variable "storage_account_name" {
  description = "Storage account name for Terraform state"
  type        = string
  default     = "pwterraformstate"
}

