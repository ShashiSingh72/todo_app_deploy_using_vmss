variable "workspaces" {
  type = map(object({
    workspaces_name      = string
    location             = string
    resource_group_name  = string
    sku                  = string
    retention_in_days    = number
    tags                 = map(string)
  }))
  
}