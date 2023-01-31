resource "confluent_kafka_topic" "customer_contact_changes" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name         = "customer_contact_changes"
  rest_endpoint      = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_topic" "customer_pref_changes" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name         = "customer_pref_changes"
  rest_endpoint      = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_topic" "transactions_changes" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name         = "transactions_changes"
  rest_endpoint      = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_topic" "transaction_decision_scores" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name         = "transaction_decision_scores"
  rest_endpoint      = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_topic" "decline_transactions" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name         = "decline_transactions"
  rest_endpoint      = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  lifecycle {
    prevent_destroy = true
  }
}
