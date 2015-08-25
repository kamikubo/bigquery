#
# Dockerfile for Fluentd+BigQuery- sample code
#
# This image will run nginx, fluentd and bigquery plugin to send access log to BigQuery.
#

FROM ubuntu:12.04

# environment
ENV DEBIAN+AF8-FRONTEND noninteractive
RUN echo +ACI-deb http://archive.ubuntu.com/ubuntu precise main universe+ACI- +AD4- /etc/apt/sources.list

# update, curl, sudo
RUN apt-get update +ACYAJg- apt-get -y upgrade
RUN apt-get -y install curl 
RUN apt-get -y install sudo

# fluentd
RUN curl -O http://packages.treasure-data.com/debian/RPM-GPG-KEY-td-agent +ACYAJg- apt-key add RPM-GPG-KEY-td-agent +ACYAJg- rm RPM-GPG-KEY-td-agent
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise-td-agent2.sh +AHw- sh 
ADD td-agent.conf /etc/td-agent/td-agent.conf
RUN curl -L https://raw.githubusercontent.com/fluent/fluentd/master/COPYING +AD4- /fluentd-license.txt

#- nginx
RUN apt-get install -y nginx
ADD nginx.conf /etc/nginx/nginx.conf
RUN curl -L http://nginx.org/LICENSE +AD4- /nginx-license.txt

# fluent-plugin-bigquery
RUN /usr/sbin/td-agent-gem install fluent-plugin-bigquery --no-ri --no-rdoc -V
RUN curl -L https://raw.githubusercontent.com/kaizenplatform/fluent-plugin-bigquery/master/LICENSE.txt +AD4- fluent-plugin-bigquery-license.txt

# start fluentd and nginx
EXPOSE 80
ENTRYPOINT /etc/init.d/td-agent restart +ACYAJg- /etc/init.d/nginx start +ACYAJg- /bin/bash
