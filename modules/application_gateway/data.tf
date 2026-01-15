data "azurerm_subnet" "data_subnet" {
    for_each = var.appgtws
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_public_ip" "data_pip" {
  for_each            = var.appgtws
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
