provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"
}

module "application_gw" {
  resource_group_name = "${var.resource_group_name}"
  source    = "../modules/application_gw/"
  subnet_name = "${var.subnet_name}"
  vnet_name = "${var.vnet_name}"
}
