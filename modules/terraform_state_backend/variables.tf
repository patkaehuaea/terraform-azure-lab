variable "container_name" {
    "description" = "Container name for Azure storage."
}

variable "key" {
    "description" = "Storage key for environment specific terraform state file."
}

variable "location" {
    "description" = "Azure region for provisioned resources."
}

variable "resource_group_name" {
    "description" = "Name of resource group holding terraform remote state."
}

variable "storage_account_name" {
    "description" = "Storage account name for environment specific Terraform state files."
}

variable "terraform_backend_config_file_path" {
    "description" = "Directory to write terraform.tf from template."
}

variable "terraform_backend_config_file_name" {
    "description" = "Name of file created from template that holds remote backend configuration."
}
