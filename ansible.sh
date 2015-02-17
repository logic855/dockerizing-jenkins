#!/bin/bash

ANSIBLE_IMAGE_TAG="flemay/ansible"
ANSIBLE_CONTAINER_NAME="ansible"

echo "Delete all containers"
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done

echo "Build ${ANSIBLE_IMAGE_TAG} image"
docker build -t ${ANSIBLE_IMAGE_TAG} images/ansible

docker rm -f ${ANSIBLE_CONTAINER_NAME}

echo "Run a container with flemay/ansible image"
docker run \
  -it \
  --name ${ANSIBLE_CONTAINER_NAME} \
  -v $(pwd)/playbooks:/opt/ansible/playbooks:ro \
  -v $(pwd)/images:/opt/ansible/images:ro \
  -v $(echo $DOCKER_CERT_PATH):/root/.docker:ro \
  -e DOCKER_HOST=tcp://$(boot2docker ip):2376 \
  -e DOCKER_TLS_VERIFY=1 \
  ${ANSIBLE_IMAGE_TAG} bash

