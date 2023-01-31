# ------------------------------------------------------
# CONNECT
# ------------------------------------------------------
resource "confluent_connector" "mysql_cdc_fraud" {
    environment {
        id = confluent_environment.Dev.id
    }
    kafka_cluster {
        id = confluent_kafka_cluster.dedicated.id
    }
    status = "RUNNING"
    config_sensitive = {
        "database.user": "postgres",
        "database.password": "rt-dwh-c0nflu3nt!",
    }
    config_nonsensitive = {
        "connector.class" = "MySQLCdcSource"
        "name": "CUSTOMERS_DB"
        "database.hostname": "someHostname"
        "database.port": "5432"
        "database.dbname": "frauddetection"
        "database.server.name": "frauddetection"
        "database.sslmode": "disable"
        "table.include.list": "frauddetection.customers, frauddetection.transactions"
        "slot.name": "camel"
        "output.data.format": "JSON_SR"
        "after.state.only": "false"
        "output.key.format": "JSON_SR"
        "tasks.max": "1"
        "kafka.auth.mode": "SERVICE_ACCOUNT"
        "kafka.service.account.id" = "${confluent_service_account.app-manager.id}"
    }
    depends_on = [
        confluent_role_binding.app-manager-rb,
        confluent_api_key.app-manager-kafka-api-key,
        confluent_schema_registry_cluster.sr
    ]
}
resource "confluent_connector" "postgres_cdc_products" {
    environment {
        id = confluent_environment.Dev.id
    }
    kafka_cluster {
        id = confluent_kafka_cluster.dedicated.id
    }
    status = "RUNNING"
    config_sensitive = {
        "database.user": "postgres",
        "database.password": "rt-dwh-c0nflu3nt!",
    }
    config_nonsensitive = {
        "connector.class" = "IbmMQSource"
        "name": "MQ_TRANSACTIONS"
        "jms.destination.name": "transactions",
        "mq.username": "admin",
        "mq.password": "admin"
        "mq.hostname": "east.mq",
        "mq.queue.manager": "test_transactions",
        "kafka.topic" : "mq_transactions_topic_0",
        "output.data.format": "JSON_SR"
        "tasks.max": "1"
        "kafka.auth.mode": "SERVICE_ACCOUNT"
        "kafka.service.account.id" = "${confluent_service_account.app-manager.id}"
    }
    depends_on = [
        confluent_role_binding.app-manager-rb,
        confluent_api_key.app-manager-kafka-api-key,
        confluent_schema_registry_cluster.sr
    ]
}