
    variable "stgs" {
        type = map(object({
            storage_account_name      = string
            resource_group_name       = string
            location                  = string
            account_tier              = string
            account_replication_type  = string
            access_tier               = optional(string)
            is_hns_enabled            = optional(bool)
            tags                      = optional(map(string))
        }))
      
    }
