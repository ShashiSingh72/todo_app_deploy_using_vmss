resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.network_interface_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.data_subnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      public_ip_address_id          = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }

  tags = each.value.tags
}

