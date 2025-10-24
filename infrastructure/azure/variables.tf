variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "pw"
}

variable "address_space" {
  description = "VNet address space"
  type        = string
  default     = "10.1.0.0/16"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

