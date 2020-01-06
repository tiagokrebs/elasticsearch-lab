# Elastic Stack
Full Elastic Stack using a Hot/Warm cluster structure collecting data from Docker VM and Nginx container using Filebeat.

- Docker: Hold all enviroment and is one of the sources for Filebeat data collection (`/var/log/host/:ro` and `/var/run/docker.sock`).
- Nginx: Simple HTTP server listening on `http://localhost:80`.
- Filebeat: Collect Docker and Nginx logs and send to Elasticsearch coordinator node.
- Coordinator: Elasticseacrh instance configured as a no data master node.
- Hot node: Elasticsearch instance that will receive first index data
- Warm node: Elasticsearch instance that will receive data after lifecycle index rotation
- Kibana: Web interface for data visualization and cluster configuration

