
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

module "key_vault" {
  key_vault_name = "kvdevcore01"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  source    = "../../../modules/common/storage/key_vault/"
}

module "certificate" {
  cert_name = "${var.cert_name}"
  key_vault_id = "${module.key_vault.key_vault_id}"
  source    = "../../../modules/common/certificate/"
}

data "azurerm_key_vault_secret" "default" {
  name      = "${var.cert_name}"
  key_vault_id = "${module.key_vault.key_vault_id}"
}

module "application_gateway" {
  application_gateway_name = "${var.application_gateway_name}"
  cert_name = "${module.certificate.cert_name}"
  cert_value = "${data.azurerm_key_vault_secret.default.value}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  source    = "../../../modules/common/application_gateway/"
  subnet_id    = "${module.virtual_network.subnet_id}"
}
