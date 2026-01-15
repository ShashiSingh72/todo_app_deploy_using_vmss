resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  for_each = var.vmsss

  name                = each.value.vmss_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku       = each.value.sku
  instances = each.value.instances

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  computer_name_prefix = lookup(each.value, "computer_name_prefix", null)
  disable_password_authentication = each.value.disable_password_authentication

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  network_interface {
    name    = each.value.network_interface.name
    primary = each.value.network_interface.primary

    ip_configuration {
      name      = each.value.network_interface.ip_configuration.name
      primary   = true
      subnet_id = data.azurerm_subnet.subnet[each.key].id
    }
  }

  tags = lookup(each.value, "tags", {})
}
