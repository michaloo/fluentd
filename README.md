# Docker fluentd

Docker image with:

- [docker-gen](https://github.com/jwilder/docker-gen)
- [fluentd](http://www.fluentd.org/)
- fluent-plugin-elasticsearch
- fluent-plugin-record-modifier
- fluent-plugin-exclude-filter

which tails docker containers logs and sends them to an elasticsearch host

By default it adds some additional tags using `record-modifier` plugin and sends only stderr logs.

Elasticsearch info is controlled by `ES_HOST` and `ES_PORT` variables.

Fluentd config is created using `/app/config/fluentd.tmpl` docker-gen template and could be easily overwritten in custom Dockerfile:

`ADD my-custom-fluentd-template.tmpl /app/config/fluentd.tmpl`


# Example usage

`docker run -d -v /var/run/docker.sock:/tmp/docker.sock -v /var/lib/docker:/var/lib/docker michaloo/fluentd`
