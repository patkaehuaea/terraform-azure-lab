variable "container_name" {
    "default" = "cnhomedev01"
}

variable "key" {
    "default" = "dev/terraform.state"
}

variable "location" {
    "default" = "westus"
}

variable "resource_group_name" {
    "default" = "rghomedev01"
}

variable "storage_account_name" {
    "default" = "sahomedev01"
}

variable "terraform_backend_config_file_path" {
    "default" = "."
}

variable "terraform_backend_config_file_name" {
    "default" = "terraform.tf"
}
