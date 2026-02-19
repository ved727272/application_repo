data "azurerm_virtual_network" "vnet" {
  name                         = var.vnet_name_spoke
  resource_group_name          = var.resource_group_name
}



data "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name
  resource_group_name          = var.resource_group_name
}

output "sqlserver_id" {
  value = data.azurerm_mssql_server.sqlserver.id  
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "sql-connection"
    private_connection_resource_id = data.azurerm_mssql_server.sqlserver.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "pvt_zone"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql_dns.id]
  }
}

resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "sql-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

