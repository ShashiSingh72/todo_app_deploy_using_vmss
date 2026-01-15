resource "azurerm_lb" "lb" {
    for_each = var.load_balancers
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configurations
    content {
      name                 = frontend_ip_configuration.value.frontend_ip_configuration_name
      public_ip_address_id = data.azurerm_public_ip.data_pip[each.key].id
    }
  }
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = var.load_balancers
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  name                           = each.value.lb_rule_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  for_each = var.load_balancers
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = each.value.backend_address_pool_name   #"BackendAddressPool"
}

resource "azurerm_lb_probe" "lb_probe" {
  for_each = var.load_balancers
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = each.value.lb_probe_name
  protocol        = each.value.protocol
  port            = each.value.port
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
}

