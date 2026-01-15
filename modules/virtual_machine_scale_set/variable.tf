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

    computer_name_prefix = optional(string)
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
