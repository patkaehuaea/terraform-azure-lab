variable "address_prefix" {
    "default" = "10.0.0.0/24"
}

variable "address_space" {
    "default" = ["10.0.0.0/16"]
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
