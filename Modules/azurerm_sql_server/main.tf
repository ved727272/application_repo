data "azurerm_key_vault" "kv" {
  for_each = var.sqldb
  name = each.value.keyvault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "sql_username" {
  for_each = var.sqldb
  name         = each.value.sql_username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "sql_password" {
  for_each = var.sqldb
  name         = each.value.sql_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.sqldb
  name                         = each.value.sqlserver_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"

  administrator_login          = data.azurerm_key_vault_secret.sql_username[each.key].value
  # administrator_login_password = var.administrator_login_password
  administrator_login_password = data.azurerm_key_vault_secret.sql_password[each.key].value

  public_network_access_enabled = false   # Security best practice

  tags = {
    environment = "production"
  }
}



resource "azurerm_mssql_database" "sqldb" {
  for_each = var.sqldb
  name           = each.value.database_name
  server_id      = azurerm_mssql_server.sqlserver[each.key].id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "S0"
  max_size_gb    = 5

  zone_redundant = false

  tags = {
    environment = "production"
  }
}

