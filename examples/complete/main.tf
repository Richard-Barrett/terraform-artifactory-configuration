terraform {
  required_version = ">= 1.5.6"
  required_providers {
    artifactory = {
      source = "jfrog/artifactory"
      version = "10.7.6"
    }
  }
}

provider "artifactory" {
  # Configuration options
}

module "artifactory_resources" {
  source  = "../.." # Path to the root of the module

  manage_backup = false
  manage_general_security = true
  manage_mail_server = true

  // Variables for artifactory_general_security
  // Fill these in as needed
  from     = "example@example.com"
  enabled  = true
  key      = "example-key"
  username = "example-username"
  password = "example-password"
}