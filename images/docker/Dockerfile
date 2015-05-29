FROM ubuntu:14.04
ENV REFRESHED_AT 20150302
RUN apt-get update -qq && apt-get install -qqy curl
RUN curl https://get.docker.com/gpg | apt-key add -
RUN echo deb http://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-get install -qqy apt-transport-https
RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core lxc-docker

# Install docker compose
#RUN curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#RUN chmod +x /usr/local/bin/docker-compose
#RUN echo PATH=/usr/local/bin:$PATH >> ~/.bashrc
