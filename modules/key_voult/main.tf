data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
    for_each = var.key_vaults
  name                        = each.value.key_vault_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption        # true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days     # 7
  purge_protection_enabled    = each.value.purge_protection_enabled       # false
  tags                        = each.value.tags

  sku_name = each.value.sku_name                       # "standard"  or "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

