variable "rgs" {
  description = "A map of resource groups to create"
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    tags                = optional(map(string))
  }))
  
}