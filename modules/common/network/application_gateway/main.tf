provider "azurerm" {
}

#################
# SSL certificate
#################

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "test" {
  name                = "kvproxy99091111"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.service_principal_object_id}"

    certificate_permissions = [
      "create","delete","deleteissuers",
      "get","getissuers","import","list",
      "listissuers","managecontacts","manageissuers",
      "setissuers","update",
    ]

    key_permissions = [
      "backup","create","decrypt","delete","encrypt","get",
      "import","list","purge","recover","restore","sign",
      "unwrapKey","update","verify","wrapKey",
    ]

    secret_permissions = [
      "backup","delete","get","list","purge","recover","restore","set",
    ]
  }

  tags = {
    environment = "development"
  }
}

resource "azurerm_key_vault_certificate" "test" {
  name     = "generated-cert"
  key_vault_id = "${azurerm_key_vault.test.id}"

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["internal.contoso.com", "domain.hello.world"]
      }

      subject            = "CN=hello-world"
      validity_in_months = 12
    }
  }
}

data "azurerm_key_vault_secret" "test" {
  name      = "generated-cert"
  key_vault_id = "${azurerm_key_vault.test.id}"
}

#####################
# application gateway
#####################

resource "azurerm_virtual_network" "net" {
  name          =  "${var.vnet_name}"
  address_space = ["10.0.0.0/16"]
  location      = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet {
    name           = "${var.subnet_name}"
    address_prefix = "10.0.0.0/24"
  }
}

resource "azurerm_subnet" "sub" {
  address_prefix = "10.0.0.0/24"
  name                  = "${var.subnet_name}"
  virtual_network_name  = "${var.vnet_name}"
  resource_group_name   = "${var.resource_group_name}"
  depends_on            = ["azurerm_virtual_network.net"]
}

resource "azurerm_application_gateway" "gw" {
  name                = "appgw"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gwip"
    subnet_id = "${azurerm_subnet.sub.id}"
  }

  frontend_port {
    name = "feport"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "feip"
    subnet_id            = "${azurerm_subnet.sub.id}"
    private_ip_address_allocation = "dynamic"
  }

  backend_address_pool {
    name = "beap"
  }

  ssl_certificate {
    name = "${azurerm_key_vault_certificate.test.name}"
    data = "${data.azurerm_key_vault_secret.test.value}"
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
    ssl_certificate_name = "${azurerm_key_vault_certificate.test.name}"
  }

  request_routing_rule {
    name                        = "rqrt"
    rule_type                   = "Basic"
    http_listener_name          = "httplist"
    backend_address_pool_name   = "beap"
    backend_http_settings_name  = "behttp"
  }

}
