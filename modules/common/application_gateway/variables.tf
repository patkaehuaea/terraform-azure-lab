variable "application_gateway_name" {
    "description" = "Application gateway name for common application_gateway module."
}

variable "cert_name" {
    "description" = "Key vault certificate name for common application_gateway module."
}

variable "cert_value" {
    "description" = "Key vault certificate value for common application_gateway module."
}

variable "location" {
    "default" = "westus"
    "description" = "Azure region for provisioned resources."
}

variable "resource_group_name" {
    "description" = "Name of resource group for common application_gateway module."
}

variable "subnet_id" {
    "description" = "Name of subnet used by application gateway."
}

