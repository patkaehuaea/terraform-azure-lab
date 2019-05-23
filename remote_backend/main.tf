provider "azurerm" {
}

module "terraform_state_backend" {
    source = "../modules/terraform_state_backend"
    container_name = "${var.container_name}"
    key = "${var.key}"
    resource_group_name = "${var.resource_group_name}"
    storage_account_name = "${var.storage_account_name}"
}

resource "azurerm_resource_group" "rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_virtual_network" "default" {
  name          =  "${var.vnet_name}"
  address_space = ["10.0.0.0/16"]
  location      = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet {
    name           = "${var.subnet_name}"
    address_prefix = "10.0.0.0/24"
  }
}

data "azurerm_subnet" "subnet" {
  name                  = "${var.subnet_name}"
  virtual_network_name  = "${var.vnet_name}"
  resource_group_name   = "${var.resource_group_name}"
  depends_on            = ["azurerm_resource_group.rg","azurerm_virtual_network.default"]
}

module "loadbalancer" {
  frontend_private_ip_address_allocation = "dynamic"
  frontend_subnet_id = "${data.azurerm_subnet.subnet.id}"
  location  = "${var.location}"
  "remote_port" {
    ssh = ["Tcp", "22"]
  }

  "lb_port" {
    https = ["443", "Tcp", "443"]
  }
  resource_group_name = "${var.resource_group_name}"
  source    = "Azure/loadbalancer/azurerm"
  type      = "private"
  version   = "1.2.1"
}
