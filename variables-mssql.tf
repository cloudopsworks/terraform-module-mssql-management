##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

## users: map of SQL Server logins and database users
# users:
#   <user_ref>:
#     name: "loginname"          # (Required) SQL Server login name.
#     databases: ["mydb"]        # (Required) List of databases to create a user in.
#     roles: ["db_owner"]        # (Optional) Database roles to assign. Default: ["db_owner"] for create_login=true, ["db_datareader"] otherwise.
#     create_login: true         # (Optional) Create a SQL Server login. Default: true.
variable "users" {
  description = "Map of SQL Server logins and database users. See inline docs for full schema."
  type        = any
  default     = {}
}

## databases: map of databases (reference only — databases are provisioned by the cloud module)
# databases:
#   <db_ref>:
#     name: "dbname"             # (Required) Database name (must already exist on the server).
variable "databases" {
  description = "Map of database references managed by this module. Databases must already exist."
  type        = any
  default     = {}
}

## server_host: SQL Server hostname or IP address (Required)
variable "server_host" {
  description = "(Required) SQL Server hostname or IP address. Passed to the server{} block of each mssql resource."
  type        = string
}

## server_port: SQL Server TCP port (Optional, default: 1433)
variable "server_port" {
  description = "(Optional) SQL Server TCP port. Default: 1433."
  type        = number
  default     = 1433
}

## password_rotation_period: days between rotations (0 = no rotation)
variable "password_rotation_period" {
  description = "(Optional) Password rotation period in days. Default: 0."
  type        = number
  default     = 0
}

## force_reset: force password replacement on next apply
variable "force_reset" {
  description = "(Optional) Force password reset on next apply. Default: false."
  type        = bool
  default     = false
}
