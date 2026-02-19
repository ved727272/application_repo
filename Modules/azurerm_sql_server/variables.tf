variable "sqldb" {
    type = map(object({
      keyvault_name = string
      resource_group_name = string 
      sql_username = string
      sql_password = string
      sqlserver_name = string
      location = string
      database_name = string

    }))
}
# variable "resource_group_name" {}
# variable "location" {}
# variable "administrator_login" {}
# variable "administrator_login_password" {}
# variable "database_name" {}
# variable "key_vault_id" {}
