#!/bin/bash

while true
do
  NREQS=$((( RANDOM % 15 ) + 1))
  echo "Faking $NREQS HTTP 200 requests..."
  for i in `eval echo {1..$NREQS}`
  do 
    curl http://nginx:80/ 2>&1 >/dev/null -s
    sleep 1
  done
  NREQS=$((( RANDOM % 5 ) + 1))
  echo "Faking $NREQS HTTP 404 requests..."
  for i in `eval echo {1..$NREQS}`
  do
    curl http://nginx/404.html 2>&1 >/dev/null -s
    sleep 1
  done
  NREQS=$((( RANDOM % 3 ) + 1))
  echo "Faking $NREQS HTTP 500 requests..."
  for i in `eval echo {1..$NREQS}`
  do
    curl -X PUT http://nginx:80/http-error 2>&1 >/dev/null -s
    sleep 1
  done
done

exit 0