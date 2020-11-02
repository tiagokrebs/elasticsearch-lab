# Single node with Filebeat ingestion
Single intance of Elasticsearch and Kibana receiving data collected from Nginx with Filebeat.

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
The intent of this single node enviroment is to explain the basics of Filebeat ingestion Elasticsearch.

Filebeats is one of data colectors created to work gracefuly with Elasticsearch. Basicaly it reads files and send o Elastic master node/cluster.

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

## Questions
Can you get the Nginx error log ingested too?

Wy our index name starts with **filebeat-** and not **access-**? How can you change this?

What happen if Filebets stops?