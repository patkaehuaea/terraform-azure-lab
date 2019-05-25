variable "address_prefix" {
  "default"     = "10.0.0.0/24"
  "description" = "Address prefix for common virtual network."
}

variable "address_space" {
  "default"     = ["10.0.0.0/16"]
  "description" = "Address space for common virtual network."
}

variable "location" {
  "default"     = "westus"
  "description" = "Azure region for common virtual network."
}

variable "resource_group_name" {
  "description" = "Resource group name for common virtual network."
}

variable "subnet_name" {
  "description" = "Name of subnet used by common virtual network."
}

variable "vnet_name" {
  "description" = "Virtual network used by common virtual network."
}
