# output "public_ip_address_id" {
#   value = azurerm_public_ip.pip["appgw"].id
# }

output "public_ip_address_id" {
  value = {
    for key, value in azurerm_public_ip.pip :
    key => value.id
  }
}