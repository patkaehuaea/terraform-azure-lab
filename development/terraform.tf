terraform {
	backend "azurerm" {
		resource_group_name = "rghomedev01"
		storage_account_name = "sahomedev01"
		container_name = "cnhomedev01"
		key = "dev/terraform.state"
	}
}
