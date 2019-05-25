output "address_prefix" {
  "value" = "${var.address_prefix}"
}

output "address_space" {
  "value" = "${var.address_space}"
}

output "location" {
  "value" = "${var.location}"
}

output "subnet_name" {
  "value" = "${var.subnet_name}"
}

output "subnet_id" {
  "value" = "${azurerm_subnet.default.id}"
}

output "vnet_name" {
  "value" = "${var.vnet_name}"
}
