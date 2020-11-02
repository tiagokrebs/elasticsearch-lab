# Single node
Single intance of Elasticsearch and Kibana using default configuration values.

There is no indexes, templates or lifecycles in this enviroment. This is a empty cluster for you to test your configurations and ingestion.

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


# Instructions
The intent of this single node enviroment is to explain de basics of indexation on Elasticsearch. 

## Indexing your first document
As Elasticsearch documentation says:
>There are a variety of ingest options for Elasticsearch, but in the end they all do the same thing: put JSON documents into an Elasticsearch index.

After you get your enviroment up and running it's time to index your first document. 
```console
$ curl -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe"
}'
```
You can do this on Kibana Dev Tools too.
```bash
PUT /customer/_doc/1
{
  "name": "John Doe"
}
```

As this is the first indexation for `customer` docs Elasticsearch will create a new index. To retrieve the indexed data you can use a GET request.
```console
$ curl -X GET "localhost:9200/customer/_doc/1?pretty"
```

## Bulk indexing
The **_bulk** API is used to index batches of documents. This is more alike Azion way of working with Elastic.
In `./data/accounts.json` we have a sample data set for this example.

```console
$ curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/_bulk?pretty&refresh" --data-binary @./data/accounts.json
```

Finaly to get the status of your indices
```console
$ curl "localhost:9200/_cat/indices?v"
```

## Questions
Can yout tell wy the indices of this example have a **yellow** health? 

WTF are these indexes starting with `.` ?

How we can delete an indexed document?