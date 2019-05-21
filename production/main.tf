provider "azurerm" {
}

module "terraform_state_backend" {
    source = "../modules/terraform_state_backend"
    container_name = "${var.container_name}"
    key = "${var.key}"
    resource_group_name = "${var.resource_group_name}"
    storage_account_name = "${var.storage_account_name}"
}
