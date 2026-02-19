module "rg" {
  source = "../../Modules/azurerm_Resource_group"
  rgs     = var.rgs
  tags   = local.common_tags
}

module "storage_account" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_storage_Account"
  stgs       = var.stgs
  tags       = local.common_tags
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_Virtual_networks"
  vnets      = var.vnets

}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../Modules/azurerm_subnets"
  subnets    = var.subnets

}

module "sql_server" {
  depends_on                   = [module.rg, module.keyvault, module.vnet, module.subnet]
  source                       = "../../Modules/azurerm_sql_server"
  sqldb = var.sqldb
  }

module "pe" {
  depends_on          = [module.sql_server, module.subnet]
  source              = "../../Modules/azurerm_private_end_point"
  resource_group_name = var.resource_group_name
  # subnet_id           = module.subnet.subnet_ids["database"]
  subnet_id           = module.subnet.subnet_ids[var.subnet_key]
  sqlserver_name      = var.sqlserver_name
  pe_name             = var.pe_name
  location            = var.location
  vnet_name_spoke     = var.vnet_name_spoke


}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_network_security_group"
  nsgs       = var.nsgs

}

module "pip" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_public_ip"
  pip        = var.pip

}

module "appgww" {
  depends_on = [module.rg, module.pip, module.vnet, module.subnet, module.keyvault]
  source     = "../../Modules/azurerm_application_gateway"

  # public_ip_address_id = module.pip.public_ip_address_id["appgw"]
  public_ip_address_id = module.pip.public_ip_address_id[var.apw_key]
  location            = var.location
  appgw_name          = var.appgw_name
  vnet_name           = var.vnet_name
  resource_group_name = var.resource_group_name
  # subnet_id           = module.subnet.subnet_ids["appgw"]
  subnet_id           = module.subnet.subnet_ids[var.subnet_apw_key]
}

module "keyvault" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_key_vault"
  keyvault = var.keyvault
 }

module "keyvault_secret" {
  depends_on = [module.keyvault]
  source     = "../../Modules/azurerm_key_vault_secret"
  kvs = var.kvs
}

module "nic" {
  depends_on = [ module.subnet ]
  source = "../../Modules/azurerm_nic"
  nics = var.nics
  
}

module "virtual_machine" {
  depends_on = [ module.nic, module.subnet, module.keyvault ]
  source = "../../Modules/azurerm_virtual_machine"
  vms = var.vms
}
