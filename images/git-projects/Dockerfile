FROM flemay/ansible:v1.8.4
ENV REFRESHED_AT 20150223

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

ADD service.sh /opt/service.sh
RUN chmod 755 /opt/service.sh

ADD playbooks/ /opt/playbooks

RUN git config --global user.name "Dockerized Jenkins"
RUN git config --global user.email "dockerizedjenkins@example.com"

WORKDIR /opt
