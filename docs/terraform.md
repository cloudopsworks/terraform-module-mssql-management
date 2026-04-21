## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_mssql"></a> [mssql](#requirement\_mssql) | ~> 0.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mssql"></a> [mssql](#provider\_mssql) | ~> 0.3 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [mssql_login.owner](https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/login) | resource |
| [mssql_login.user](https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/login) | resource |
| [mssql_user.owner](https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/user) | resource |
| [mssql_user.user](https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/user) | resource |
| [random_password.owner](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_rotating.owner](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_rotating.user](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | Map of database references managed by this module. Databases must already exist. | `any` | `{}` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_force_reset"></a> [force\_reset](#input\_force\_reset) | (Optional) Force password reset on next apply. Default: false. | `bool` | `false` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_password_rotation_period"></a> [password\_rotation\_period](#input\_password\_rotation\_period) | (Optional) Password rotation period in days. Default: 0. | `number` | `0` | no |
| <a name="input_server_host"></a> [server\_host](#input\_server\_host) | (Required) SQL Server hostname or IP address. Passed to the server{} block of each mssql resource. | `string` | n/a | yes |
| <a name="input_server_port"></a> [server\_port](#input\_server\_port) | (Optional) SQL Server TCP port. Default: 1433. | `number` | `1433` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_users"></a> [users](#input\_users) | Map of SQL Server logins and database users. See inline docs for full schema. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databases"></a> [databases](#output\_databases) | Map of db\_ref → { name } for all referenced databases. |
| <a name="output_owner_passwords"></a> [owner\_passwords](#output\_owner\_passwords) | Map of user\_ref → login password (sensitive) for create\_login=true users. Consumed by cloud modules for secret storage. |
| <a name="output_owner_usernames"></a> [owner\_usernames](#output\_owner\_usernames) | Map of user\_ref → SQL Server login name for create\_login=true users. |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | Map of user\_ref → login password (sensitive) for create\_login=false users. |
| <a name="output_user_usernames"></a> [user\_usernames](#output\_user\_usernames) | Map of user\_ref → SQL Server login name for create\_login=false users. |
| <a name="output_users"></a> [users](#output\_users) | Map of user\_ref → { name, create\_login } for all managed users. |
