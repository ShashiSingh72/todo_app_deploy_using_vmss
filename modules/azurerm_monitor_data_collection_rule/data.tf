data "azurerm_storage_account" "data_stg" {
    for_each = var.data_collection_rules
  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_storage_container" "data_stg_container" {
  for_each = var.data_collection_rules
  name               = "${each.value.storage_account_name}-container"
  storage_account_id = data.azurerm_storage_account.data_stg[each.key].id
}

data "azurerm_log_analytics_workspace" "analytics_workspace" {
    for_each = var.data_collection_rules
  name                = each.value.log_analytics_workspace_name
  resource_group_name = each.value.resource_group_name
} 

data "azurerm_virtual_machine_scale_set" "data_vmss" {
  for_each = var.data_collection_rules
  name                = each.value.virtual_machine_scale_set_name
  resource_group_name = each.value.resource_group_name
}