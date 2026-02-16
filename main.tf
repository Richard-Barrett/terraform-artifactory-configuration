terraform {
  required_version = ">= 1.5.6"
  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "10.7.6"
    }
  }
}

# Configure the Artifactory Backup settings
resource "artifactory_backup" "this" {
  count = var.manage_backup ? 1 : 0

  key                      = "${var.key}-${replace(timestamp(), "/[^0-9]/", "")}"
  cron_exp                 = var.cron_exp
  retention_period_hours   = var.retention_period_hours
  excluded_repositories    = var.excluded_repositories
  create_archive           = var.create_archive
  exclude_new_repositories = var.exclude_new_repositories
  send_mail_on_error       = var.send_mail_on_error
  verify_disk_space        = var.verify_disk_space
  export_mission_control   = var.export_mission_control
}

# Configure Artifactory general security settings
resource "artifactory_general_security" "this" {
  count = var.manage_general_security ? 1 : 0

  enable_anonymous_access = var.enable_anonymous_access
}

# Configure Artifactory mail server settings
resource "artifactory_mail_server" "this" {
  count = var.manage_mail_server ? 1 : 0

  enabled         = var.enabled
  artifactory_url = var.artifactory_url
  from            = var.from
  host            = var.host
  username        = var.username
  password        = var.password
  port            = var.port
  subject_prefix  = var.subject_prefix
  use_ssl         = var.use_ssl
  use_tls         = var.use_tls
}