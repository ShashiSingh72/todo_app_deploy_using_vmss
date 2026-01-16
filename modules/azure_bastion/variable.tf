variable "bastion_hosts" {
  type = map(object({
    bastion_name           = string
    location               = string
    resource_group_name    = string
    vnet_name              = string
    allocation_method      = string
    sku                    = string
    bastion_subnet_name    = string
    address_prefixes = list(string)
    ip_configuration       = list(object({
      ip_configuration_name = string
    }))
  }))
  }