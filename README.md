# Docker fluentd

Docker image with:

- [docker-gen](https://github.com/jwilder/docker-gen)
- [fluentd](http://www.fluentd.org/)
- fluent-plugin-elasticsearch
- fluent-plugin-record-modifier
- fluent-plugin-exclude-filter

which tails docker containers logs and sends them to an elasticsearch host

By default it adds some additional tags using `record-modifier` plugin and sends only stderr logs.

Elasticsearch info is controlled by `ES_HOST` and `ES_PORT` variables which will be overwritten if you link `elastic` search container.

Fluentd config is created using `/app/config/fluentd.tmpl` docker-gen template and could be easily overwritten in custom Dockerfile:

`ADD my-custom-fluentd-template.tmpl /app/config/fluentd.tmpl`


# Simple usage

`docker run -d -v /var/run/docker.sock:/tmp/docker.sock -v /var/lib/docker:/var/lib/docker michaloo/fluentd`

By default only stderr logs from container created with "LOG=true" environmental variable would be send.


# Run example

Provided example assumes using [crane](https://github.com/michaelsauter/crane).
Change dir to `examples/` and execute `crane lift`. This will bring three containers:

- michaloo/fluentd
- michaloo/elasticsearch
- ubuntu:14.04 as log producer

After lifting them up you can go to
`http://your-docker-host:9200/_plugin/kibana3/index.html#/dashboard/file/logstash.json`
to see the example logs (you may need to wait a minute for logs to show).
