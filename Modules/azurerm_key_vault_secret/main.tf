data "azurerm_key_vault" "kv_id" {
  for_each                    = var.kvs
  name                        = each.value.key_vault_name
  resource_group_name         = each.value.resource_group_name
} 

resource "azurerm_key_vault_secret" "kvs" {
  for_each = var.kvs
  name         = each.value.secret_user
  value        = each.value.secret_pass
  key_vault_id = data.azurerm_key_vault.kv_id[each.key].id
}





# resource "azurerm_key_vault_secret" "username" {
#   for_each = var.username
#   name         = each.value.username
#   value        = each.value.value
#   # key_vault_id = azurerm_key_vault.kv["kv1"].id
#   key_vault_id = azurerm_key_vault.kv[each.key].id
# }

# resource "azurerm_key_vault_secret" "password" {
#   for_each = var.password
#   name         = each.value.password_name
#   value        = each.value.value
#   # key_vault_id = azurerm_key_vault.kv["kv1"].id
#   key_vault_id = azurerm_key_vault.kv[each.key].id
# }

