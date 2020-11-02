# Xpack security SSL
Multiple node enviroment with SSL encripted transport (between nodes).

To see how to create the certificates [see here](https://aziontech.atlassian.net/l/c/cZAxQjag).

There is no indexes, templates or lifecycles in this enviroment. This is a empty cluster for you to test your configurations and ingestion.

Start the enviroment with:
```console
$ docker-compose up -d
```

To check Elasticsearch health run:
```console
$ curl -u elastic:elastic http://localhost:9200/_cat/health

1582809517 13:18:37 docker-cluster green 2 1 0 0 0 0 0 0 - 100.0%
```


# Instructions
This enviroment was made to test the use of certied connection between nodes provided by `xpack.security.transport.ssl` configuration

## Indexing your first document
After you get your enviroment up and running it's time to index your first document and check if our transport SSL is working fine.

Check the nodes from cluster.
```console
$ curl -u elastic:elastic http://localhost:9200/_cat/nodes

172.26.0.2 26 69 48 1.89 1.35 0.97 im * coordinator
172.26.0.3 39 69 48 1.89 1.35 0.97 di - hot-node
```

Index a single document.
```console
$ curl -u elastic:elastic -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe"
}'

{
  "_index" : "customer",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
```

Check if our `hot-node` receive the shard.
```console
$ curl -u elastic:elastic http://localhost:9200/_cat/shards

customer 0 p STARTED    1 3.4kb 172.26.0.3 hot-node
customer 0 r UNASSIGNED
```

## Questions