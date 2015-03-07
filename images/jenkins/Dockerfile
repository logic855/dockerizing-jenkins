FROM flemay/ansible-docker
ENV REFRESHED_AT 20141127

RUN apt-get update -qq && apt-get install -qqy curl
RUN apt-get update -qq && apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core

ENV JENKINS_HOME /opt/jenkins/data

RUN mkdir -p $JENKINS_HOME
ENV JENKINS_DATA_PATH /opt/volumes/jenkins-data
ENV PROJECTS_PATH ${JENKINS_DATA_PATH}/projects

ADD ./jenkins.sh /opt/jenkins.sh
RUN chmod +x /opt/jenkins.sh
ADD playbooks/ /opt/playbooks

# Add jenkins executable and plugins
#ADD dockerized-jenkins/jenkins/jenkins-1.597.war /opt/jenkins/jenkins.war
#ADD dockerized-jenkins/plugins ${JENKINS_HOME}/plugins/

# set executable and plugins
ENV SHARED_VOLUME_PATH /opt/volumes/dockerized-jenkins
VOlUME ${SHARED_VOLUME_PATH}
ADD dockerized-jenkins/  ${SHARED_VOLUME_PATH}/
RUN ln -s ${SHARED_VOLUME_PATH}/plugins ${JENKINS_HOME}/plugins
RUN ln -s ${SHARED_VOLUME_PATH}/jenkins/jenkins.war /opt/jenkins/jenkins.war

EXPOSE 8080

ENTRYPOINT [ "/opt/jenkins.sh" ]
