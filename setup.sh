#!/bin/bash

PROJECTS_IMAGE_TAG="flemay/jenkins-projects"
PROJECTS_CONTAINER_NAME="jenkins-projects"

JENKINS_IMAGE_TAG="flemay/jenkins"
JENKINS_CONTAINER_NAME="jenkins"

echo "Delete all containers"
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done

echo "Build ${PROJECTS_IMAGE_TAG} image"
docker build -t ${PROJECTS_IMAGE_TAG} jenkins-projects

echo "Build ${JENKINS_IMAGE_TAG} image"
docker build -t ${JENKINS_IMAGE_TAG} jenkins

echo "Create ${PROJECTS_CONTAINER_NAME} based on ${PROJECTS_IMAGE_TAG}"
docker run --name ${PROJECTS_CONTAINER_NAME} ${PROJECTS_IMAGE_TAG} ls /opt/projects

sh ./git-projects.sh clone

echo "Run a container with flemay/jenkins image"
docker run \
  -p 8080:8080 \
  --name ${JENKINS_CONTAINER_NAME} \
  --privileged \
  -d \
  --volumes-from ${PROJECTS_CONTAINER_NAME} \
  ${JENKINS_IMAGE_TAG}

echo "Open Jenkins in a browser"
echo open http://$(boot2docker ip 2>/dev/null):8080
