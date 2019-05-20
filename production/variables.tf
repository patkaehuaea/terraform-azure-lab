variable "container_name" {
    "default" = "cnhomeprod01"
}

variable "key" {
    "default" = "prod/terraform.state"
}

variable "location" {
    "default" = "westus"
}

variable "resource_group_name" {
    "default" = "rghomeprod01"
}

variable "storage_account_name" {
    "default" = "sahomeprod01"
}

variable "terraform_backend_config_file_path" {
    "default" = "."
}

variable "terraform_backend_config_file_name" {
    "default" = "terraform.tf"
}
