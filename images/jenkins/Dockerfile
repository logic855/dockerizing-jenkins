FROM flemay/docker
ENV REFRESHED_AT 20141127

RUN apt-get update -qq && apt-get install -qqy curl
RUN apt-get update -qq && apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core

ENV JENKINS_HOME /opt/jenkins/data

RUN mkdir -p $JENKINS_HOME
ENV PROJECTS_PATH /opt/projects/dockerized-jenkins-projects

# Make symbol links to use data container
RUN ln -s ${PROJECTS_PATH}/jobs $JENKINS_HOME/jobs
RUN ln -s ${PROJECTS_PATH}/config/config.xml $JENKINS_HOME/config.xml

ADD ./jenkins.sh /usr/local/bin/jenkins.sh
RUN chmod +x /usr/local/bin/jenkins.sh

# Add jenkins executable and plugins
ADD dockerized-jenkins/jenkins/jenkins-1.597.war /opt/jenkins/jenkins.war
ADD dockerized-jenkins/plugins ${JENKINS_HOME}/plugins/

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/jenkins.sh" ]
