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

