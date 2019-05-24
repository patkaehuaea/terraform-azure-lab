output "key_vault_id" {
    "value" = "${azurerm_key_vault.default.id}"
}

output "key_vault_name" {
    "value" = "${var.key_vault_name}"
}

output "location" {
    "value" = "${var.location}"
}
