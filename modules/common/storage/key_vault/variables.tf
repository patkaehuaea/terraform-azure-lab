variable "key_vault_name" {
  description = "Globally unique name for common key vault."
}

variable "location" {
  default     = "westus"
  description = "Azure region for common virtual network."
}

variable "resource_group_name" {
  description = "Resource group name for common virtual network."
}
