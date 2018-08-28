ARG distro=stretch
FROM resin/rpi-raspbian:$distro

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

RUN apt-get update && apt-get install -y snmp snmp-mibs-downloader --no-install-recommends && ( /usr/bin/download-mibs ; rm -rf /var/lib/apt/lists/* )

ENV MIBDIRS /var/lib/snmp/mibs/iana:/var/lib/snmp/mibs/ietf:/usr/share/snmp/mibs/

VOLUME /etc/telegraf

CMD telegraf
