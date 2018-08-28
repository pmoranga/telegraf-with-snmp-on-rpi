FROM resin/rpi-alpine:edge
MAINTAINER Pedro <pmoranga@gmail.com>

ENV TELEGRAF_VERSION 1.7.3

#ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz /tmp/
# https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz
RUN cd /tmp \
        && curl -s -o /tmp/telegraf.tar.gz https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& tar -zxvf /tmp/telegraf.tar.gz \
	&& rm /tmp/telegraf.tar.gz \
	&& cp -r /tmp/telegraf/* / \
	&& rm -r /tmp/telegraf \
	&& (telegraf config > /etc/telegraf/telegraf.conf)

RUN apk add --no-cache net-snmp-tools

VOLUME /etc/telegraf

CMD telegraf
