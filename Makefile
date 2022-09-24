.PHONY: build
build:
	docker-compose -f docker-compose.yml -f extensions/filebeat/filebeat-compose.yml build

.PHONY: dev
dev:
	docker-compose -f docker-compose.yml -f extensions/filebeat/filebeat-compose.yml up --remove-orphans

.PHONY: topic
topic:
	docker-compose exec kafka kafka-topics.sh --create --topic ${TOPIC} --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181

.PHONY: message
message:
	docker-compose exec kafka kafka-console-producer.sh --topic ${TOPIC} --broker-list localhost:9092

.PHONY: consumer
consumer:
	docker-compose exec kafka kafka-console-consumer.sh --topic ${TOPIC} --from-beginning --bootstrap-server localhost:9092

.PHONY: purge
purge:
	docker-compose -f docker-compose.yml -f extensions/filebeat/filebeat-compose.yml rm -fsv
