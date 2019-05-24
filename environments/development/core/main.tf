
provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"
}

module "virtual_network" {
  address_prefix = "${var.address_prefix}"
  address_space = "${var.address_space}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  source    = "../../../modules/common/network/virtual_network/"
  subnet_name = "${var.subnet_name}"
  vnet_name = "${var.vnet_name}"
}
