# https://github.com/jamtur01/dockerbook-code/blob/master/code/5/jenkins/Dockerfile
FROM ubuntu:14.04
ENV REFRESHED_AT 20141123

RUN apt-get update -qq && apt-get install -qqy curl
RUN apt-get update -qq && apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core 

ENV JENKINS_HOME /opt/jenkins/data
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

RUN mkdir -p $JENKINS_HOME

# Make symbol links to use data containers
RUN ln -s /opt/jobs $JENKINS_HOME/jobs
RUN ln -s /opt/plugins $JENKINS_HOME/plugins
RUN ln -s /opt/config/config.xml $JENKINS_HOME/config.xml

ADD ./jenkins.war /opt/jenkins/jenkins.war
RUN chmod +x /opt/jenkins/jenkins.war

ADD ./jenkins.sh /usr/local/bin/jenkins.sh
RUN chmod +x /usr/local/bin/jenkins.sh

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/jenkins.sh" ]
