resource "azurerm_resource_group" "rg" {
    for_each = var.rgs
  name     = each.value.resource_group_name
  location = each.value.location
  managed_by = lookup(each.value, "managed_by", null)
  tags     = lookup(each.value, "tags", null)
}

