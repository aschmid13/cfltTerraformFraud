terraform {
  required_providers {
    confluent = {
      source = "confluentinc/confluent"
      version = "1.28.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key 
  cloud_api_secret = var.confluent_cloud_api_secret
}


resource "confluent_service_account" "app-manager" {
  display_name = "app-manager"
  description  = "Service Account for orders app"
}

resource "confluent_role_binding" "app-manager-rb" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "EnvironmentAdmin"
  crn_pattern = confluent_environment.Dev.resource_name
}