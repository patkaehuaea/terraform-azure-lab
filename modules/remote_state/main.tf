locals {
  terraform_backend_config_file = "${format("%s/%s", var.terraform_backend_config_file_path, var.terraform_backend_config_file_name)}"
}

provider "azurerm" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "${var.container_name}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

data "template_file" "terraform_backend_config" {
  template = "${file("${path.module}/templates/terraform.tf.tpl")}"

  vars {
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    storage_account_name = "${azurerm_storage_account.sa.name}"
    container_name       = "${var.container_name}"
    key                  = "${var.key}"
  }
}

resource "local_file" "terraform_backend_config" {
  content  = "${data.template_file.terraform_backend_config.rendered}"
  filename = "${local.terraform_backend_config_file}"
}
