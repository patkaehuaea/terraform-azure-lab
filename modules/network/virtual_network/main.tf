provider "azurerm" {}

resource "azurerm_virtual_network" "default" {
  name                = "${var.vnet_name}"
  address_space       = "${var.address_space}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  subnet {
    name           = "${var.subnet_name}"
    address_prefix = "${var.address_prefix}"
  }
}

resource "azurerm_subnet" "default" {
  address_prefix       = "${var.address_prefix}"
  name                 = "${var.subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.resource_group_name}"
  depends_on           = ["azurerm_virtual_network.default"]
}
