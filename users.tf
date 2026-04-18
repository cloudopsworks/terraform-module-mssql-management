##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "time_rotating" "user" {
  for_each = {
    for k, v in var.users : k => v if !try(v.create_login, true) && var.password_rotation_period > 0
  }
  rotation_days = var.password_rotation_period
}

resource "random_password" "user" {
  for_each = {
    for k, v in var.users : k => v if !try(v.create_login, true)
  }
  length           = 25
  special          = true
  override_special = "=_-+@~#!"
  min_upper        = 2
  min_special      = 2
  min_numeric      = 2
  min_lower        = 2
  keepers = {
    force_reset = var.force_reset
  }
  lifecycle {
    replace_triggered_by = [time_rotating.user]
  }
}

resource "mssql_login" "user" {
  for_each   = { for k, v in var.users : k => v if !try(v.create_login, true) }
  login_name = try(each.value.name, each.key)
  password   = random_password.user[each.key].result
  server {
    host = var.server_host
    port = var.server_port
  }
}

resource "mssql_user" "user" {
  for_each = {
    for item in flatten([
      for k, v in var.users : [
        for db in try(v.databases, []) : {
          key       = "${k}-${db}"
          login_key = k
          username  = try(v.name, k)
          database  = db
          roles     = try(v.roles, ["db_datareader"])
        }
      ] if !try(v.create_login, true)
    ]) : item.key => item
  }
  username   = each.value.username
  login_name = mssql_login.user[each.value.login_key].login_name
  database   = each.value.database
  roles      = each.value.roles
  server {
    host = var.server_host
    port = var.server_port
  }
  depends_on = [mssql_login.user]
}
