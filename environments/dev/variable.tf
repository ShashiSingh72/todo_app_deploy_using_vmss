variable "rgs" {
  description = "A map of resource groups to create"
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    tags                = optional(map(string))
  }))

}

variable "vnets" {
  type = map(object({
    vnet_name           = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
  }))

}
variable "subnets" {
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string))
    tags                 = optional(map(string))
  }))

}


variable "stgs" {
  description = "A map of storage accounts to create"
  type = map(object({
    storage_account_name     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    access_tier              = optional(string)
    is_hns_enabled           = optional(bool)
    tags                     = optional(map(string))
  }))

}

variable "nsgs" {
  description = "A map of Network Security Groups to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    tags = map(string)
  }))

}
variable "nics" {
  description = "A map of Network Interface Cards to create"
  type = map(object({
    network_interface_name = string
    location               = string
    resource_group_name    = string
    vnet_name              = string
    subnet_name            = string
    ip_configuration = map(object({
      name                          = string
      private_ip_address_allocation = string
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
    }))
    tags = optional(map(string))
  }))

}

variable "vmsss" {
  description = "Map of Linux VM Scale Sets"
  type = map(object({

    vmss_name           = string
    location            = string
    resource_group_name = string

    vnet_name   = string
    subnet_name = string

    sku       = string
    instances = number

    admin_username = string
    admin_password = string

    computer_name_prefix            = optional(string)
    disable_password_authentication = bool

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    network_interface = object({
      name    = string
      primary = bool
      ip_configuration = object({
        name = string
      })
    })

    tags = optional(map(string))
  }))
}

variable "pips" {
  type = map(object({
    public_ip_name      = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = optional(map(string))
  }))
}

variable "load_balancers" {
  description = "A map of Load Balancers to create"
  type = map(object({
    lb_name             = string
    location            = string
    resource_group_name = string
    frontend_ip_configurations = map(object({
      frontend_ip_configuration_name = string
    }))
    lb_rule_name                   = string
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
    backend_address_pool_name      = string
    lb_probe_name                  = string
    port                           = number
    interval_in_seconds            = number
    number_of_probes               = number
    public_ip_name                 = string
  }))

}

variable "appgtws" {
  description = "A map of Application Gateways to create"
  type = map(object({
    appgtw_name         = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    vnet_name           = string
    public_ip_name      = string
    skus = map(object({
      sku_name = string
      tier     = string
      capacity = number
    }))
    gateway_ip_configurations = map(object({
      gateway_ip_configuration_name = string

    }))
  }))
}

variable "bastion_hosts" {
  type = map(object({
    bastion_name        = string
    location            = string
    resource_group_name = string
    vnet_name           = string
    allocation_method   = string
    sku                 = string
    bastion_subnet_name = string
    address_prefixes    = list(string)
    ip_configuration = list(object({
      ip_configuration_name = string
    }))
  }))
}

variable "key_vaults" {
  type = map(object({
    key_vault_name              = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    tags                        = optional(map(string))
  }))

}

variable "workspaces" {
  type = map(object({
    workspaces_name     = string
    location            = string
    resource_group_name = string
    sku                 = string
    retention_in_days   = number
    tags                = map(string)
  }))

}

variable "data_collection_rules" {
  type = map(object({
    data_collection_rule_name                = string
    resource_group_name                      = string
    location                                 = string
    storage_account_name                     = string
    log_analytics_workspace_name             = string
    virtual_machine_scale_set_name           = string
    virtual_machine_scale_set_extension_name = string
  }))

}
