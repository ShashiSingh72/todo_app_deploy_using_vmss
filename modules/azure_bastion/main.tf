resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastion_hosts
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration

    content {
      name                 = ip_configuration.value.ip_configuration_name
      subnet_id            = azurerm_subnet.bastion_subnet[each.key].id
      public_ip_address_id = azurerm_public_ip.bastion_public_ip[each.key].id
    }
  }
}
resource "azurerm_public_ip" "bastion_public_ip" {
    for_each = var.bastion_hosts

  name                = "${each.value.bastion_name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method     #"Static"
  sku                 = each.value.sku                   #"Standard"
}
resource "azurerm_subnet" "bastion_subnet" {
    for_each = var.bastion_hosts

  name                 = each.value.bastion_subnet_name    #"AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}

  
