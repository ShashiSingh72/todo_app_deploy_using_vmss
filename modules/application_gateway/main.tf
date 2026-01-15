resource "azurerm_application_gateway" "appgateway" {
  for_each            = var.appgtws
  name                = each.value.appgtw_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  dynamic "sku" {
    for_each = each.value.skus
    content {
      name     = sku.value.sku_name #"Standard_V2"
      tier     = sku.value.tier     #"Standard_V2"
      capacity = sku.value.capacity #2
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.value.gateway_ip_configuration_name #"appGatewayIpConfig"
      subnet_id = data.azurerm_subnet.data_subnet[each.key].id
    }
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.data_pip[each.key].id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }
  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}



