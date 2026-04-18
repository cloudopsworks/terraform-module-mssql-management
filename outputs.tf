##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "owner_passwords" {
  description = "Map of user_ref → login password (sensitive) for create_login=true users. Consumed by cloud modules for secret storage."
  sensitive   = true
  value       = { for k, v in random_password.owner : k => v.result }
}

output "owner_usernames" {
  description = "Map of user_ref → SQL Server login name for create_login=true users."
  value       = { for k, v in mssql_login.owner : k => v.login_name }
}

output "user_passwords" {
  description = "Map of user_ref → login password (sensitive) for create_login=false users."
  sensitive   = true
  value       = { for k, v in random_password.user : k => v.result }
}

output "user_usernames" {
  description = "Map of user_ref → SQL Server login name for create_login=false users."
  value       = { for k, v in mssql_login.user : k => v.login_name }
}

output "databases" {
  description = "Map of db_ref → { name } for all referenced databases."
  value       = { for k, v in var.databases : k => { name = try(v.name, k) } }
}

output "users" {
  description = "Map of user_ref → { name, create_login } for all managed users."
  value = {
    for k, v in var.users : k => {
      name         = try(v.name, k)
      create_login = try(v.create_login, true)
    }
  }
}
