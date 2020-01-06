#!/bin/bash

# wait for Elasticsearch
until curl -s http://coordinator:9200/_cat/health -o /dev/null; do
    echo Waiting for Elasticsearch...
    sleep 1
done

# wait for Kibana
until curl -s http://kibana:5601/ -o /dev/null; do
    echo Waiting for Kibana...
    sleep 1
done