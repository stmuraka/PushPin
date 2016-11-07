# This Dockerfile creates a Pushpin container
# Reverse proxy for realtime web services http://pushpin.org/
# https://github.com/fanout/pushpin

FROM ubuntu:xenial
MAINTAINER Shaun Murakami <stmuraka@us.ibm.com>

# Add pushpin APT repository
RUN echo deb https://dl.bintray.com/fanout/debian fanout-xenial main | sudo tee /etc/apt/sources.list.d/fanout.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61

# Update container
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
## Add other packages here
    apt-transport-https \
    software-properties-common \
    pushpin \
# Cleanup package files
 && apt-get autoremove \
 && apt-get autoclean

# Fix timezone
RUN rm -f /etc/localtime \
 && ln -s /usr/share/zoneinfo/${CONTAINER_TIMEZONE} /etc/localtime

ENV TERM="xterm"

EXPOSE 7999 5561

WORKDIR /root
