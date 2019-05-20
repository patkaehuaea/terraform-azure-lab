provider "azurerm" {
}

module "terraform_state_backend" {
    source = "../modules/terraform_state_backend"
    container_name = "${var.container_name}"
    key = "${var.key}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    storage_account_name = "${var.storage_account_name}"
    terraform_backend_config_file_path = "${var.terraform_backend_config_file_path}"
    terraform_backend_config_file_name = "${var.terraform_backend_config_file_name}"
}
