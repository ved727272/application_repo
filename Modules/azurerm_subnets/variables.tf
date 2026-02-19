variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
  }))
}