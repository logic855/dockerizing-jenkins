FROM flemay/ansible:v1.8.4
ENV REFRESHED_AT 20150223

# Update aptitude with new repo
RUN apt-get update

# Install git
RUN apt-get install -y git

RUN mkdir /root/.ssh
ADD ssh-keys/ /root/.ssh/
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN chmod 700 -R ~/.ssh/

ADD service.sh /opt/service.sh
RUN chmod 755 /opt/service.sh

ADD playbooks/ /opt/playbooks

RUN git config --global user.name "git-jenkins container"
RUN git config --global user.email "dockerizedjenkins@example.com"

WORKDIR /opt
ENV JENKINS_REPO git@github.com:flemay/dockerized-jenkins.git
