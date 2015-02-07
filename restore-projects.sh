#!/bin/bash
BACKUP_PROJECTS_IMAGE_TAG="flemay/backup-projects"
BACKUP_PROJECTS_CONTAINER_NAME="backup-projects"

PROJECTS_CONTAINER_NAME="jenkins-projects"

echo "Build ${BACKUP_PROJECTS_IMAGE_TAG} image"
docker build -t ${BACKUP_PROJECTS_IMAGE_TAG} backup-projects

echo "Delete ${BACKUP_PROJECTS_CONTAINER_NAME} container"
docker stop ${BACKUP_PROJECTS_CONTAINER_NAME}
docker rm ${BACKUP_PROJECTS_CONTAINER_NAME}

echo "Create ${BACKUP_PROJECTS_CONTAINER_NAME} based on ${BACKUP_PROJECTS_IMAGE_TAG}"
docker run \
  --rm \
  --name ${BACKUP_PROJECTS_CONTAINER_NAME} \
  --volumes-from ${PROJECTS_CONTAINER_NAME} \
  ${BACKUP_PROJECTS_IMAGE_TAG} /opt/service.sh pull
  #${BACKUP_PROJECTS_IMAGE_TAG} tail -f /root/.ssh/id_rsa.pub

#echo "Wait till the backup-projects container is removed"
#docker inspect ${BACKUP_PROJECTS_CONTAINER_NAME}
#result=$?
#until [ ${result} -ne 0 ]; do
#    sleep 0.1;
#    docker inspect ${BACKUP_PROJECTS_CONTAINER_NAME}
#    result=$?
#done;
