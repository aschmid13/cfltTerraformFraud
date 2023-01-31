resource "confluent_ksql_cluster" "ksql_cluster" {
    display_name = "ksql-cluster-someRandomId"
    csu = 4
    environment {
        id = confluent_environment.Dev.id
    }
    kafka_cluster {
        id = confluent_kafka_cluster.dedicated.id
    }
    credential_identity {
        id = confluent_service_account.app-manager.id
    }
    depends_on = [
        confluent_role_binding.app-manager-rb,
        confluent_api_key.app-manager-kafka-api-key,
        confluent_schema_registry_cluster.sr
    ]
}