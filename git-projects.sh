#!/bin/bash
ACTION=$1

if [[ "${ACTION}" != "clone" && "${ACTION}" != "push" ]]
then
  echo "USAGE: $0 [clone|push COMMIT_MSG]"
  exit 1
fi

if [[ "${ACTION}" == "push" && "${2}" == "" ]]
  then
  echo "ERROR push needs a commit message"
  exit 1
fi

BACKUP_PROJECTS_IMAGE_TAG="flemay/git-projects"
BACKUP_PROJECTS_CONTAINER_NAME="git-projects"

PROJECTS_CONTAINER_NAME="jenkins-projects"

echo "Build ${BACKUP_PROJECTS_IMAGE_TAG} image"
docker build -t ${BACKUP_PROJECTS_IMAGE_TAG} git-projects

echo "Delete ${BACKUP_PROJECTS_CONTAINER_NAME} container"
docker stop ${BACKUP_PROJECTS_CONTAINER_NAME}
docker rm ${BACKUP_PROJECTS_CONTAINER_NAME}

echo "Create ${BACKUP_PROJECTS_CONTAINER_NAME} based on ${BACKUP_PROJECTS_IMAGE_TAG}"
docker run \
  --rm \
  --name ${BACKUP_PROJECTS_CONTAINER_NAME} \
  --volumes-from ${PROJECTS_CONTAINER_NAME} \
  ${BACKUP_PROJECTS_IMAGE_TAG} /opt/service.sh ${ACTION} "${2}"
  #${BACKUP_PROJECTS_IMAGE_TAG} tail -f /root/.ssh/id_rsa.pub
