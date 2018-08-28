ARG distro=bionic
FROM arm32v7/ubuntu:$distro
#ARG distro=stretch
#FROM resin/rpi-raspbian:$distro

MAINTAINER Pedro <pmoranga@gmail.com>

ENV TELEGRAF_VERSION 1.7.3

RUN set -x ; \
        apt-get update \
        && apt-get install -y snmp snmp-mibs-downloader wget ca-certificates --no-install-recommends \
        && /usr/bin/download-mibs \
        && apt remove -y snmp-mibs-downloader \
        && apt-get autoremove -y \
        && rm -rf /var/lib/apt/lists/* 

# https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz
RUN cd /tmp \ 
        && wget -c https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& tar -zxvf /tmp/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& rm /tmp/telegraf-${TELEGRAF_VERSION}_linux_armhf.tar.gz \
	&& cp -r /tmp/telegraf/* / \
	&& rm -r /tmp/telegraf \
	&& (telegraf config > /etc/telegraf/telegraf.conf)


ENV MIBDIRS /var/lib/snmp/mibs/iana:/var/lib/snmp/mibs/ietf:/usr/share/snmp/mibs/

VOLUME /etc/telegraf

CMD telegraf
