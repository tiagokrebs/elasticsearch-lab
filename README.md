# Elastic LAB

Laboratory for learning Elastick Stack and Azion's data collect and cluster administration.
Based on [Elastic Docs](https://www.elastic.co/guide/en/elastic-stack/7.3/installing-elastic-stack.html) and [this project](https://github.com/xeraa/elastic-docker).

## The Elastic Stack
The ELK (Elastic Stack) is a group of apps created by Elastic.co who work each other in order to collect, transform, store and beautifully show data. Azion uses all tools of the this stack.

- Beats/Logstash: collects and trasform data (ETL). Some times Azion uses other collect tools (like Timber) to work with Logstash instead of Elastic Beats.
- Elasticksearch: storage the data in form of indexes and shards of indexes.
- Kibana: web interface to perform data visualization and configuration of Elasticsearch.

To learn more about ELK [see here](https://www.elastic.co/pt/what-is/elk-stack).

# Single Elasticsearch + Kibana
Docker needs at least 3Gb memory.
```console
docker-compose up
docker-compose --detach
docker-compose down
docker-compose down -v  # erase volumes
docker ps -a
docker logs <container>
```

# Elastic Stack
Loading...
