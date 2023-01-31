data "confluent_schema_registry_region" "sr_region" {
    cloud = "AWS"
    region = "us-east-2"
    package = "ESSENTIALS"
}
resource "confluent_schema_registry_cluster" "sr" {
    package = data.confluent_schema_registry_region.sr_region.package
    environment {
        id = confluent_environment.Dev.id
    }
    region {
        id = data.confluent_schema_registry_region.sr_region.id
    }
}