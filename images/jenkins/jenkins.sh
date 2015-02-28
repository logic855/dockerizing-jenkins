#!/bin/bash

echo "make symbol link to use projects"
ln -s ${PROJECTS_PATH}/jobs $JENKINS_HOME/jobs

echo "copy config file from ${PROJECTS_PATH}"
cp -f ${PROJECTS_PATH}/config/config.xml $JENKINS_HOME/

exec java -jar /opt/jenkins/jenkins.war
