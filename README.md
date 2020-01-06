# Elastic Lab

Laboratory for learning about Elastick Stack and Azion's data collect/cluster administration.
Based on [Elastic Docs](https://www.elastic.co/guide/en/elastic-stack/7.3/installing-elastic-stack.html) and [this project](https://github.com/xeraa/elastic-docker).

## The Elastic Stack
The ELK (Elastic Stack) is a group of apps created by Elastic.co that work each other in order to collect, transform, store and beautifully show data. Azion uses all tools of the this stack.

- Beats/Logstash: collects and trasform data (ETL). Some times Azion uses other collect tools (like Timber) to work with Logstash instead of Elastic Beats.
- Elasticksearch: storage the data in form of indexes and shards of indexes.
- Kibana: web interface to perform data visualization and configuration of Elasticsearch.

To learn more about ELK [see here](https://www.elastic.co/pt/what-is/elk-stack).

## The Lab
Docker needs at least 3Gb memory for these enviroments.

```bash
# to start an enviroment up
docker-compose up

# detached mode (hiden logs)
docker-compose up -d

# get running containers and health status
docker ps -a

# follow logs (if detached)
docker logs <container name> -f

# to stop an aviroment
docker-compose down

# stop and remove local volumes
docker-compose down -v
```

Go to `single-node` or `elatic-stack` folders for more details.

## To do
- Elastic Stack
    - Nginx with filebeat collect
    - Nginx with Azion Timber collect
    - Add more Beats tools (auditbeat, heartbeat, metricbeat, packetbeat)
- App Search
- Machine Learning
- Elasticsearch Upgrade
