resource "azurerm_log_analytics_workspace" "log_awork" {
    for_each = var.workspaces
  name                = each.value.workspaces_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku       # e.g., "PerGB2018"
  retention_in_days   = each.value.retention_in_days     # e.g., 30
  tags                = each.value.tags

}




