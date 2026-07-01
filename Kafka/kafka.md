# Step 1: Installing Java (JDK)


Update your package list:

sudo apt update


Install OpenJDK:

sudo apt install openjdk-11-jdk -y


Verify the installation:

java -version


# Step 2: Download and Extract Apache Kafka


Download the latest version of Kafka from the official website. You can use wget to download Kafka directly:

wget https://archive.apache.org/dist/kafka/3.4.0/kafka_2.12-3.4.0.tgz




Extract the downloaded tar file:

tar -xzf kafka_2.12-3.4.0.tgz



Move the extracted folder to /usr/local/kafka:

sudo mv kafka_2.12-3.4.0 /usr/local/kafka


# Step 3: Start Zookeeper

Kafka uses Zookeeper for managing and coordinating Kafka brokers. To start Zookeeper:

cd /usr/local/kafka



Start Zookeeper using the default configuration:

sudo bin/zookeeper-server-start.sh config/zookeeper.properties




# Step 4: Start the Kafka Server



With Zookeeper running, you can now start the Kafka broker.

Open another terminal and navigate to the Kafka directory:

cd /usr/local/kafka

Start the Kafka broker:

sudo bin/kafka-server-start.sh config/server.properties


This will start the Kafka server using the default configuration. You should see logs indicating that the Kafka server is up and running.


# Step 5: Create a Kafka Topic

Open another terminal and navigate to the Kafka directory:

cd /usr/local/kafka



Create a new topic:

sudo bin/kafka-topics.sh --create --topic my-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1


# Step 6: Produce Messages to the Kafka Topic


Open another terminal and navigate to the Kafka directory:

cd /usr/local/kafka



Start the Kafka producer:

sudo bin/kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9092



This will start a console where you can type messages. Each line you enter will be sent as a message to the “my-topic” topic.


>Hello, Kafka!
>This is my first message.


# Step 7: Consume Messages from the Kafka Topic

Open another terminal and navigate to the Kafka directory:

cd /usr/local/kafka


Start the Kafka consumer:

sudo bin/kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9092






