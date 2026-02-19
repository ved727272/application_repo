resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

#   dynamic "security_rule" {
#     for_each = each.value.security_rules
#     content {
#   name                        = "Allow-HTTP"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"

#     }
    
#   }
}

resource "azurerm_network_security_rule" "allow_http" {
  for_each = var.nsgs

  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}
