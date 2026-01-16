variable "data_collection_rules" {
  type = map(object({
    data_collection_rule_name      = string
    resource_group_name            = string
    location                       = string
    storage_account_name           = string
    log_analytics_workspace_name   = string
    virtual_machine_scale_set_name = string
    virtual_machine_scale_set_extension_name = string

  }))
  
}
