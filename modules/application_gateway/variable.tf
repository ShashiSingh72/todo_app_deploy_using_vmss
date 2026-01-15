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

