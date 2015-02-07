FROM ubuntu:14.04
ENV REFRESHED_AT 20150223
ENV PROJECTS_REPO git@github.com:flemay/dockerized-jenkins-projects.git

# Update aptitude with new repo
RUN apt-get update

# Install git
RUN apt-get install -y git

RUN mkdir /root/.ssh
ADD ssh-keys/id_rsa.dockerizedjenkins /root/.ssh/id_rsa
ADD ssh-keys/id_rsa.dockerizedjenkins.pub /root/.ssh/id_rsa.pub
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN chmod 700 -R ~/.ssh/

WORKDIR /opt
RUN git clone ${PROJECTS_REPO}

