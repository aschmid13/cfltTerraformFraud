resource "confluent_environment" "Dev" {
  display_name = "Development"

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_cluster" "dedicated" {
  display_name = "standard_kafka_cluster"
  availability = "MULTI_ZONE"
  cloud        = "AWS"
  region       = "us-east-2"
  standard {}

  environment {
    id = confluent_environment.Dev.id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.dedicated.id
    api_version = confluent_kafka_cluster.dedicated.api_version
    kind        = confluent_kafka_cluster.dedicated.kind

    environment {
      id = confluent_environment.Dev.id
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}