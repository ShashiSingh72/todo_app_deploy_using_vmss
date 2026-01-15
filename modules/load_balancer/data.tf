data "azurerm_public_ip" "data_pip" {
    for_each = var.load_balancers
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

# data "azurerm_lb" "data_lb" {
#     for_each = var.load_balancers
#   name                = each.value.lb_name
#   resource_group_name = each.value.resource_group_name
# }