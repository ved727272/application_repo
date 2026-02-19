resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}


# output "virtual_network_id" {
#   value = azurerm_virtual_network.vnet["spoke"].id
# }

output "virtual_network_id" {
  value = {
    for key, value in azurerm_virtual_network.vnet :
    key => value.id
  }
  
}


