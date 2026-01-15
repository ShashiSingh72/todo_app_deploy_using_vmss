variable "nics" {
  description = "A map of Network Interface Cards to create"
  type = map(object({
    network_interface_name = string
    location               = string
    resource_group_name    = string
    vnet_name              = string
    subnet_name           = string
    ip_configuration = map(object({
      name                          = string
      private_ip_address_allocation = string
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
    }))
    tags = optional(map(string))
  }))

}
