<img align="right" width="60" height="60" src="images/terraform.png">

# terraform-artifactory-configuration

Terraform Module to Manage Artifactory Configurations

This Terraform module is designed to manage three key resources related to JFrog Artifactory: `artifactory_backup`, `artifactory_general_security`, and `artifactory_mail_server`. 

- `artifactory_backup` handles the backup settings of Artifactory, allowing you to define backup schedules, exclusions, and other related settings.
- `artifactory_general_security` manages the general security settings of Artifactory.
- `artifactory_mail_server` manages the mail server settings of Artifactory.

The module provides flexibility, allowing you to manage any combination of these resources by setting the corresponding `manage_*` variables. Each resource has its own set of variables that you need to provide when calling the module. 

The module is versioned, ensuring stability and reliability in its usage. However, the actual usage of the module, including the required and optional variables for each resource, may vary depending on the specific implementation of the module.

Example CICD with `BitBucket` and `Codefresh`:

![Image](./images/diagram.png)

## Notes

1. `Module Purpose`: This Terraform module is designed to manage three key resources related to JFrog Artifactory: artifactory_backup, artifactory_general_security, and artifactory_mail_server.
2. `Resource Management`: The module provides flexibility in managing these resources. You can choose to manage one, two, or all three resources at once by setting the manage_backup, manage_general_security, and manage_mail_server variables.
3. `Variables`: Each resource has its own set of variables that you need to provide when calling the module. Some variables are required, while others are optional and have default values.
4. `Versioning`: The module is versioned, so you can specify the version when calling the module to ensure you're using a stable and tested version.
5. `Usage`: The actual usage of the module, including the required and optional variables for each resource, may vary depending on the specific implementation of the module.
6. `Considerations`: When using this module, consider the Terraform version, dependencies, permissions, cost, timezone, and security. Make sure your Terraform version is compatible with the module, the dependencies are created before the module is applied, the account running the Terraform scripts has sufficient permissions, the cost fits within your budget, the timezone is correct if you're using cron expressions for scheduling, and sensitive data is handled properly.

## Usage

The following includes some examples on how you can use this module.

### Minimal Usage

The minimal usage is to manage the general security setting with the `manage_general_security` set to `true`:

```
```hcl
module "artifactory_resources" {
  source  = "https://github.com/Richard-Barrett/terraform-artifactory-configuration"
  version = "1.0.0"

  manage_backup = false
  manage_general_security = true
  manage_mail_server = false

  // Variables for artifactory_general_security
  // Fill these in as needed
  // ...
}
```

NOTE: YOU ARE ONLY MANAGING ANONYMOUS ACCESS AND NOT THE BACKUP OR MAIL SERVER WITH THIS CONFIGURATION

### Basic Usage

To use the module, you need to call it in your Terraform configuration and provide values for the required variables. Here's an example:

```terraform
module "artifactory_resources" {
  source  = "https://github.com/Richard-Barrett/terraform-artifactory-configuration"
  version = "1.0.0"

  manage_backup = true
  manage_general_security = false
  manage_mail_server = true

  // Variables

 for

 artifactory_backup
  key = "backup_key"
  cron_exp = "0 17 * * 1-5"
  retention_period_hours = 1000
  excluded_repositories = []
  create_archive = false
  exclude_new_repositories = true
  send_mail_on_error = true
  verify_disk_space = true
  export_mission_control = true

  // Variables for artifactory_mail_server
  // Fill these in as needed
  // ...
}
```

In this example, the `artifactory_backup` and `artifactory_mail_server` resources will be managed, but the `artifactory_general_security` resource will not be managed because `manage_general_security` is set to `false`.
The rest of the variables are the inputs to your module, which correspond to the properties of the `artifactory_backup`, `artifactory_general_security`, and `artifactory_mail_server` resources. You need to fill in the variables for `artifactory_mail_server` as needed.

If you only want to manage the `artifactory_backup` resource, you can set the `manage_backup` variable to true and the `manage_general_security` and `manage_mail_server` variables to false. Here's an example:

```hcl
module "artifactory_resources" {
  source  = "https://github.com/Richard-Barrett/terraform-artifactory-configuration"
  version = "1.0.0"

  manage_backup = true
  manage_general_security = false
  manage_mail_server = false

  // Variables for artifactory_backup
  key = "backup_key"
  cron_exp = "0 17 * * 1-5"
  retention_period_hours = 1000
  excluded_repositories = []
  create_archive = false
  exclude_new_repositories = true
  send_mail_on_error = true
  verify_disk_space = true
  export_mission_control = true
}
```

In this example, only the artifactory_backup resource will be managed. The `artifactory_general_security` and `artifactory_mail_server` resources will not be managed because their corresponding variables are set to false.


If you only want to manage the `artifactory_general_security` resource, you can set the `manage_general_security` variable to true and the manage_backup and `manage_mail_server` variables to false. Here's an example:

```hcl
module "artifactory_resources" {
  source  = "https://github.com/Richard-Barrett/terraform-artifactory-configuration"
  version = "1.0.0"

  manage_backup = false
  manage_general_security = true
  manage_mail_server = false

  // Variables for artifactory_general_security
  // Fill these in as needed
  // ...
}
```

In this example, only the `artifactory_general_security` resource will be managed. The `artifactory_backup` and `artifactory_mail_server` resources will not be managed because their corresponding variables are set to false.

### Advanced Usage with All Inputs Plus Options

Advanced usage of the module would involve setting more variables and possibly using more complex values. Here's an example:

```hcl
module "artifactory_resources" {
  source  = "https://github.com/Richard-Barrett/terraform-artifactory-configuration"
  version = "1.0.0"

  manage_backup = true
  manage_general_security = true
  manage_mail_server = true

  // Advanced variables for artifactory_backup
  key = "backup_key"
  cron_exp = "0 17 * * 1-5"
  retention_period_hours = 1000
  excluded_repositories = ["repo1", "repo2"]
  create_archive = true
  exclude_new_repositories = false
  send_mail_on_error = true
  verify_disk_space = true
  export_mission_control = true

  // Advanced variables for artifactory_general_security
  // Fill these in as needed
  // ...

  // Advanced variables for artifactory_mail_server
  // Fill these in as needed
  // ...
}
```

In this example, all three resources will be managed because their corresponding variables are set to true. The `artifactory_backup` resource has more complex values for excluded_repositories and `create_archive`.
The rest of the variables are the advanced inputs to your module, which correspond to the properties of the `artifactory_backup`, `artifactory_general_security`, and `artifactory_mail_server` resources. You need to fill in the advanced variables for `artifactory_general_security` and `artifactory_mail_server` as needed.

### Considerations

When using this module, consider the following:

1. `Resource Management`: You have the flexibility to manage one, two, or all three resources (artifactory_backup, artifactory_general_security, artifactory_mail_server) at once. Make sure to set the manage_* variables correctly based on your needs.
2. `Required Variables`: Each resource likely has required variables that you must provide. Ensure you understand what each variable represents and provide appropriate values.
3. `Optional Variables`: There may be optional variables that have default values. You can override these defaults if necessary.
4. `Module Version`: Always specify the version of the module to ensure you're using a stable and tested version that won't change unexpectedly.
5. `Terraform Version`: Make sure your Terraform version is compatible with the module. Some modules require a minimum Terraform version.
6. `Dependencies`: If the module depends on other resources being present (like a network or a storage account), make sure those resources are created before the module is applied.
7. `Permissions`: Ensure that the account running the Terraform scripts has sufficient permissions to create, update, and delete the resources managed by the module.
8. `Cost`: Each resource created by the module may incur costs. Make sure you understand the pricing for each resource and that it fits within your budget.
9. `Timezone`: If you're using cron expressions for scheduling, remember that the timezone is based on the server where the job is running. Adjust the time in the cron expression accordingly if your server is in a different timezone.
10. `Security`: Be careful with sensitive data. Use Terraform variables or secrets management systems to handle sensitive data like passwords or API keys.

## Overview

This Terraform module manages three resources related to JFrog Artifactory: `artifactory_backup`, `artifactory_general_security`, and `artifactory_mail_server`.

1. `artifactory_backup`: This resource manages the backup settings of Artifactory. It allows you to define when and how backups are performed, which repositories to exclude from backups, and other backup-related settings.
2. `artifactory_general_security`: This resource manages the general security settings of Artifactory. It can be used to configure various security-related settings.
3. `artifactory_mail_server`: This resource manages the mail server settings of Artifactory. It allows you to define the mail server that Artifactory uses to send emails.

The module provides flexibility in managing these resources. You can choose to manage one, two, or all three resources at once by setting the `manage_backup`, `manage_general_security`, and `manage_mail_server` variables.

Each resource has its own set of variables that you need to provide when calling the module. Some variables are required, while others are optional and have default values.

The module is versioned, so you can specify the version when calling the module to ensure you're using a stable and tested version.

Please note that the actual usage of the module, including the required and optional variables for each resource, may vary depending on the specific implementation of the module.

### Inputs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_artifactory"></a> [artifactory](#requirement\_artifactory) | 10.7.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_artifactory"></a> [artifactory](#provider\_artifactory) | 10.7.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [artifactory_backup.this](https://registry.terraform.io/providers/jfrog/artifactory/10.7.6/docs/resources/backup) | resource |
| [artifactory_general_security.this](https://registry.terraform.io/providers/jfrog/artifactory/10.7.6/docs/resources/general_security) | resource |
| [artifactory_mail_server.this](https://registry.terraform.io/providers/jfrog/artifactory/10.7.6/docs/resources/mail_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifactory_url"></a> [artifactory\_url](#input\_artifactory\_url) | URL of the Artifactory instance | `string` | `"http://localhost:8081/artifactory"` | no |
| <a name="input_create_archive"></a> [create\_archive](#input\_create\_archive) | Whether to create an archive | `bool` | `false` | no |
| <a name="input_cron_exp"></a> [cron\_exp](#input\_cron\_exp) | Cron expression for backup | `string` | `"0 0 12 * * ? *"` | no |
| <a name="input_enable_anonymous_access"></a> [enable\_anonymous\_access](#input\_enable\_anonymous\_access) | Whether to enable anonymous access | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to enable the mail server | `bool` | `true` | no |
| <a name="input_exclude_new_repositories"></a> [exclude\_new\_repositories](#input\_exclude\_new\_repositories) | Whether to exclude new repositories | `bool` | `true` | no |
| <a name="input_excluded_repositories"></a> [excluded\_repositories](#input\_excluded\_repositories) | List of repositories to exclude | `list(string)` | `[]` | no |
| <a name="input_export_mission_control"></a> [export\_mission\_control](#input\_export\_mission\_control) | Whether to export to mission control | `bool` | `true` | no |
| <a name="input_from"></a> [from](#input\_from) | Email address to send from | `string` | `""` | no |
| <a name="input_host"></a> [host](#input\_host) | Host of the mail server | `string` | `""` | no |
| <a name="input_key"></a> [key](#input\_key) | Unique key for the backup | `string` | `"backup"` | no |
| <a name="input_manage_backup"></a> [manage\_backup](#input\_manage\_backup) | Whether to manage the backup resource | `bool` | `true` | no |
| <a name="input_manage_general_security"></a> [manage\_general\_security](#input\_manage\_general\_security) | Whether to manage the general security resource | `bool` | `true` | no |
| <a name="input_manage_mail_server"></a> [manage\_mail\_server](#input\_manage\_mail\_server) | Whether to manage the mail server resource | `bool` | `true` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the mail server | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | Port of the mail server | `number` | `25` | no |
| <a name="input_retention_period_hours"></a> [retention\_period\_hours](#input\_retention\_period\_hours) | Retention period in hours | `number` | `24` | no |
| <a name="input_send_mail_on_error"></a> [send\_mail\_on\_error](#input\_send\_mail\_on\_error) | Whether to send mail on error | `bool` | `true` | no |
| <a name="input_subject_prefix"></a> [subject\_prefix](#input\_subject\_prefix) | Prefix for the subject of the email | `string` | `"[Artifactory]"` | no |
| <a name="input_use_ssl"></a> [use\_ssl](#input\_use\_ssl) | Whether to use SSL for the mail server | `bool` | `true` | no |
| <a name="input_use_tls"></a> [use\_tls](#input\_use\_tls) | Whether to use TLS for the mail server | `bool` | `true` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the mail server | `string` | `""` | no |
| <a name="input_verify_disk_space"></a> [verify\_disk\_space](#input\_verify\_disk\_space) | Whether to verify disk space | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
