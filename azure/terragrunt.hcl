locals {
  location            = "westeurope"
  name_prefix         = "pw"
  storage_account     = "pwterraformstate"
  resource_group_name = "rg-pw-terraform-state-netnut"
}

generate "provider_azurerm" {
  path      = "provider_azurerm.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "#"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${local.resource_group_name}"
    storage_account_name = "${local.storage_account}"
    container_name       = "tfstate"
    key                  = "azure/${path_relative_to_include()}/terraform.tfstate"
  }
}
EOF
}

inputs = {
  location    = local.location
  name_prefix = local.name_prefix
}

