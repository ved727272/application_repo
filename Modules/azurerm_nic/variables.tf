variable "nics" {
  type = map(object({
    nic_name  = string
    subnet_name = string
    resource_group_name = string
    virtual_network_name = string
    location            = string
  }))
}