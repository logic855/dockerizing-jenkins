#!/bin/bash
JENKINS_IMAGE_TAG="flemay/jenkins:1.598"
JENKINS_CONTAINER_NAME="jenkins"

PLUGINS_CONTAINER_NAME="jenkins-plugins"
PROJECTS_CONTAINER_NAME="jenkins-projects"

echo "Build ${JENKINS_IMAGE_TAG} image"
docker build -t ${JENKINS_IMAGE_TAG} jenkins/jenkins-1.598

echo "Delete Jenkins container"
docker stop jenkins
docker rm jenkins

echo "Create ${JENKINS_CONTAINER_NAME} based on ${JENKINS_IMAGE_TAG}"
docker run \
  -p 8080:8080 \
  --name ${JENKINS_CONTAINER_NAME} \
  -d \
  --volumes-from ${PLUGINS_CONTAINER_NAME} \
  --volumes-from ${PROJECTS_CONTAINER_NAME} \
  ${JENKINS_IMAGE_TAG}

echo "Wait 20 seconds to let Jenkins boots"
sleep 20

echo "Open Jenkins in a browser"
open http://$(boot2docker ip 2>/dev/null):8080
