FROM hypriot/rpi-alpine-scratch:edge
MAINTAINER Pedro <pmoranga@gmail.com>

ENV TELEGRAF_VERSION 1.7.3

ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz /tmp/
# https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz
RUN cd /tmp \
	&& tar -zxvf /tmp/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& rm /tmp/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& cp -r /tmp/telegraf/* / \
	&& rm -r /tmp/telegraf \
	&& (telegraf config > /etc/telegraf/telegraf.conf)

RUN apk add --no-cache net-snmp-tools

VOLUME /etc/telegraf

CMD telegraf
