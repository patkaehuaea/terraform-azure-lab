provider "azurerm" {
}

data "azurerm_client_config" "current" {}

resource "azurerm_application_gateway" "default" {
  name                = "${var.application_gateway_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gwip"
    subnet_id = "${var.subnet_id}"
  }

  frontend_port {
    name = "feport"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "feip"
    subnet_id            = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }

  backend_address_pool {
    name = "beap"
  }

  ssl_certificate {
    name = "${var.cert_name}"
    data = "${var.cert_value}"
    password = ""
  }

  backend_http_settings {
    name                  = "behttp"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "https"
    request_timeout       = 5
  }

  http_listener {
    name                           = "httplist"
    frontend_ip_configuration_name = "feip"
    frontend_port_name             = "feport"
    protocol                       = "https"
    ssl_certificate_name = "${var.cert_name}"
  }

  request_routing_rule {
    name                        = "rqrt"
    rule_type                   = "Basic"
    http_listener_name          = "httplist"
    backend_address_pool_name   = "beap"
    backend_http_settings_name  = "behttp"
  }
}
