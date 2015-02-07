FROM ubuntu:14.04
ENV REFRESHED_AT 20141123

RUN apt-get update -qq && apt-get install -qqy curl
RUN apt-get update -qq && apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core 

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

RUN mkdir -p $JENKINS_HOME
ENV PROJECTS_PATH /opt/projects/dockerized-jenkins-projects
# Make symbol links to use data containers
RUN ln -s ${PROJECTS_PATH} $JENKINS_HOME/jobs
RUN ln -s /opt/plugins $JENKINS_HOME/plugins
RUN ln -s ${PROJECTS_PATH}/config.xml $JENKINS_HOME/config.xml

ADD ./jenkins.sh /usr/local/bin/jenkins.sh
RUN chmod +x /usr/local/bin/jenkins.sh

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/jenkins.sh" ]
