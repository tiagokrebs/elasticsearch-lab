#!/bin/bash

# wait for elasticsearch
until curl -s http://coordinator:9200/_cat/health -o /dev/null; do
    echo Waiting for Elasticsearch...
    sleep 1
done

# wait for kibana
until curl -s http://kibana:5601/ -o /dev/null; do
    echo Waiting for Kibana...
    sleep 1
done

# load pipelines.
# PIPELINES=/usr/local/bin/pipelines/*.json
# for f in $PIPELINES
# do
#      filename=$(basename $f)
#      pipeline_id="${filename%.*}"
#      echo "Loading $pipeline_id ingest chain..."
#      curl -s  -H 'Content-Type: application/json' -XPUT http://coordinator:9200/_ingest/pipeline/$pipeline_id -d@$f
# done

# load index templates
TEMPLATES=/usr/local/bin/templates/*.json
for f in $TEMPLATES
do
     filename=$(basename $f)
     template_id="${filename%.*}"
     echo "Loading $template_id template..."
     curl -s  -H 'Content-Type: application/json' -XPUT http://coordinator:9200/_template/$template_id -d@$f
     # add index pattern in kibana
     curl -s -H 'Content-Type: application/json' -XPUT http://coordinator:9200/.kibana/index-pattern/$template_id-* \
     -d "{\"title\" : \"$template_id-*\",  \"timeFieldName\": \"@timestamp\"}"
done