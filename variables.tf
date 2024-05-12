variable "artifactory_url" {
  description = "URL of the Artifactory instance"
  type        = string
  default     = "http://localhost:8081/artifactory"
  sensitive   = true
}

variable "create_archive" {
  description = "Whether to create an archive"
  type        = bool
  default     = false
}

variable "cron_exp" {
  description = "Cron expression for backup"
  type        = string
  default     = "0 0 12 * * ? *"
  validation {
    condition     = length(split(" ", var.cron_exp)) == 7
    error_message = "The cron expression must have 7 fields (Seconds, Minutes, Hours, Day of Month, Month, Day of Week, Year)."
  }
}

variable "enable_anonymous_access" {
  description = "Whether to enable anonymous access"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "Whether to enable the mail server"
  type        = bool
  default     = true
}

variable "exclude_new_repositories" {
  description = "Whether to exclude new repositories"
  type        = bool
  default     = true
}

variable "excluded_repositories" {
  description = "List of repositories to exclude"
  type        = list(string)
  default     = []
}

variable "export_mission_control" {
  description = "Whether to export to mission control"
  type        = bool
  default     = true
}

variable "from" {
  description = "Email address to send from"
  type        = string
  default     = ""
}

variable "host" {
  description = "Host of the mail server"
  type        = string
  sensitive   = true
  default     = ""
}

variable "key" {
  description = "Unique key for the backup"
  type        = string
  default     = "backup"
}

variable "password" {
  description = "Password for the mail server"
  type        = string
  sensitive   = true
  default     = ""
}

variable "port" {
  description = "Port of the mail server"
  type        = number
  default     = 25
}

variable "retention_period_hours" {
  description = "Retention period in hours"
  type        = number
  default     = 24
}

variable "send_mail_on_error" {
  description = "Whether to send mail on error"
  type        = bool
  default     = true
}

variable "subject_prefix" {
  description = "Prefix for the subject of the email"
  type        = string
  default     = "[Artifactory]"
}

variable "use_ssl" {
  description = "Whether to use SSL for the mail server"
  type        = bool
  default     = true
}

variable "use_tls" {
  description = "Whether to use TLS for the mail server"
  type        = bool
  default     = true
}

variable "username" {
  description = "Username for the mail server"
  type        = string
  sensitive   = true
  default     = ""
}

variable "verify_disk_space" {
  description = "Whether to verify disk space"
  type        = bool
  default     = true
}

// Management Variables
variable "manage_backup" {
  description = "Whether to manage the backup resource"
  type        = bool
  default     = true
}

variable "manage_general_security" {
  description = "Whether to manage the general security resource"
  type        = bool
  default     = true
}

variable "manage_mail_server" {
  description = "Whether to manage the mail server resource"
  type        = bool
  default     = true
}