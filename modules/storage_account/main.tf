resource "azurerm_storage_account" "name" {
    for_each                     = var.stgs
    name                         = each.value.storage_account_name
    resource_group_name          = each.value.resource_group_name
    location                     = each.value.location
    account_tier                 = each.value.account_tier
    account_replication_type     = each.value.account_replication_type
    access_tier                  = lookup(each.value, "access_tier", null)
    is_hns_enabled               = lookup(each.value, "is_hns_enabled", null)
    tags                         = lookup(each.value, "tags", null)
    }
