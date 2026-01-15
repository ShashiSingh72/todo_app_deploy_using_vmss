locals {
  frontend_port_name             = "appgw-fe-port-80"
  frontend_ip_configuration_name = "appgw-fe-ip"
  backend_address_pool_name      = "todo-BackendPool"
    http_setting_name              = "appgw-http-setting"
    listener_name                  = "appgw-listener"
    request_routing_rule_name      = "appgw-routing-rule"
    
}