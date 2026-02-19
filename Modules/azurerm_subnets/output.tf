# output "database_subnet_id" {
#   value = azurerm_subnet.subnet["database"].id
  
# }

# output "appgw_subnet_id" {
#   value = azurerm_subnet.subnet["appgw"].id
  
# }

output "subnet_ids" {
  value = {
    for key, value in azurerm_subnet.subnet :
    key => value.id
  }
}


