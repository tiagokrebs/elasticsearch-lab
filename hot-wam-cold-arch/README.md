# Elastic Stack
Full Elastic Stack using a Hot/Warm/Cold cluster structure collecting data from Docker VM and Nginx container using Filebeat.

- Docker: Hold all enviroment and is one of the sources for Filebeat data collection.
- Nginx: Simple HTTP server listening on local 80 port.
- Filebeat: Collect Docker and Nginx logs and send to Elasticsearch coordinator node.
- Logstash: Receives and improves Nginx logs with pipelines.
- Coordinator: Elasticseacrh instance configured as a **no data master node**.
- Hot node: Elasticsearch instance that always receive the first index data.
- Warm node: Elasticsearch instance that will receive data after lifecycle index rotation.
- Cold node: Elasticsearch instance for indexes last step before deletion.
- Kibana: Web interface for data visualization and cluster configuration.

Start the enviroment with:
```console
$ docker-compose up -d
```

To check Elasticsearch health run:
```console
$ curl http://localhost:9200/_cat/health

1578329037 16:43:57 docker-cluster green 3 2 10 5 0 0 0 0 - 100.0%
```

To access Kibana interface go to <http://localhost:5601>.

To check if Nginx is up and running:
```console
$ curl http://localhost:80

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```

# Instructions
The intent of this enviroment is to explain how a hot-warm-cold architeture works.

This type of architeture is used to improve ingestion and query time and at the same time to a better use of avaible hardware.

## Nginx
As Nginx is one of the softwares used by Azion it will be part of this example. This service exposes an HTTP server on 80 port for us to send requests in order to gerenate some logs.

With this logs in place we can use Filebeat to colect them.

We also need make requests to this instance of Nginx. This enviroment already have that. Take a look at `fake-reqs` service on `docker-compose` file.

The original Nginx logs can be found on `./logs/nginx` created on this directory after the enviroment start.
```console
$ tail -f logs/nginx/access.log
```

## Filebeat
Filebeat needs two basic thins to start doing his job: something to colect (in this case provide by Nginx module) and Elasticsearch address.

```yaml
filebeat.modules:
  - module: nginx
    access:
      var.paths: ["/var/log/nginx/access.log*"]

output.elasticsearch:
  hosts: ["elasticsearch:9200"]
```

With this configuration Filbeat will monitor the Nginx **acess.log** file and periodicaly send his data to Elasticsearch index.

Now is a good time to see some logs and follow Filebeat work.
```console
$ docker logs filebeat -f
```


## Questions/Tasks

### Let's talk about Logstash Coordinator Hot Node Warm Node and Cold Node.

Did you notice we dont't have a cold node? Can you add? Don't forget to do the lifecycle too.

Add some index patterns to we can see our indexes on Kibana Discover.

Seems like Nginx logs doesn't have any template can you create one?

This is realy is an hot-warm-cold architecture?