variable "application_gateway_name" {
    "default" = "agdevcore01"
}

variable "address_prefix" {
    "default" = "10.0.0.0/24"
}

variable "address_space" {
    "default" = ["10.0.0.0/16"]
}

variable "cert_name" {
    "default" = "crdevcore01"
}

variable "location" {
    "default" = "westus"
}

variable "resource_group_name" {
    "default" = "rgdevcore01"
}

variable "subnet_name" {
    "default" = "sndevcore01"
}

variable "vnet_name" {
    "default" = "vndevcore01"
}
