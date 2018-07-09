FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
    nodejs curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt
ADD https://github.com/etsy/statsd/archive/v0.8.0.tar.gz statsd.tar.gz
RUN tar -xvf statsd.tar.gz
RUN ln -s statsd-0.8.0 statsd
RUN rm statsd.tar.gz

COPY ./config.js /opt/statsd/

WORKDIR /opt/statsd

EXPOSE 8125/udp
EXPOSE 8126

ENTRYPOINT ["nodejs", "stats.js", "config.js"]
