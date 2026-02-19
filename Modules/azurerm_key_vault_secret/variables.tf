variable "kvs" {
  type = map(object({
    key_vault_name = string
    resource_group_name = string
    secret_user = string
    secret_pass = string 

  }))
  
}


# variable "kvs" {
#    type = map(object({
#     secret_user = string
#     secret_pass = string 
#     vault_key = string
#   }))
# }


# variable "password" {
#   type = map(object({
#     password_name = string
#     value = string 
#   }))

# }
# variable "username" {
#    type = map(object({
#     username = string
#     value = string 
#   }))
# }
