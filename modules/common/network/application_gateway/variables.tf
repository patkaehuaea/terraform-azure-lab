variable "location" {
    "default" = "westus"
    "description" = "Azure region for provisioned resources."
}

variable "resource_group_name" {
    "description" = "Name of resource group holding terraform remote state."
}

variable "subnet_name" {
    "description" = "Name of subnet used by application gateway."
}

variable "vnet_name" {
    "description" = "Virtual network used by application gateway."
}
