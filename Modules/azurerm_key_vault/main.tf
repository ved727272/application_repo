data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each                    = var.keyvault
  name                        = each.value.key_vault_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


# resource "azurerm_key_vault_secret" "kvs" {
#   for_each = var.kvs
#   name         = each.value.secret_user
#   value        = each.value.secret_pass
#   key_vault_id = azurerm_key_vault.kv["kv1"].id
#   key_vault_id = azurerm_key_vault.kv[each.value.vault_key].id
#   key_vault_id = azurerm_key_vault.kv[each.key].id
# }





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

