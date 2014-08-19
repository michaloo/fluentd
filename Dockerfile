FROM ubuntu:14.04
MAINTAINER Michal Raczka me@michaloo.net

RUN apt-get update && \
    apt-get install -y curl libcurl4-openssl-dev wget supervisor ruby ruby-dev make python-pip && \
    pip install supervisor-stdout

RUN gem install fluentd --no-ri --no-rdoc && \
    fluent-gem install fluent-plugin-elasticsearch fluent-plugin-record-modifier && \
    mkdir /etc/fluentd/

RUN cd /usr/local/bin && \
    curl -L https://github.com/jwilder/docker-gen/releases/download/0.3.3/docker-gen-linux-amd64-0.3.3.tar.gz | \
    tar -xzv

# install templater
RUN cd /usr/local/bin && \
    curl -L https://github.com/michaloo/templater/releases/download/v0.0.1/templater.tar.gz | \
    tar -xzv

# add startup scripts and config files
ADD ./bin    /app/bin
ADD ./config /app/config

#RUN mkdir /app
WORKDIR /app

ENV ES_HOST localhost
ENV ES_PORT 9200
ENV LOG_ENV production
ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["/app/bin/before_supervisord"]
