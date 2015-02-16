#!/bin/bash

ANSIBLE_IMAGE_TAG="flemay/ansible"
ANSIBLE_CONTAINER_NAME="ansible"

echo "Build ${ANSIBLE_IMAGE_TAG} image"
docker build -t ${ANSIBLE_IMAGE_TAG} ansible

docker rm -f ${ANSIBLE_CONTAINER_NAME}

echo "Run a container with flemay/ansible image"
docker run \
  -it \
  --name ${ANSIBLE_CONTAINER_NAME} \
  -v $(echo $DOCKER_CERT_PATH):/root/.docker \
  -e DOCKER_HOST=tcp://$(boot2docker ip):2376 \
  -e DOCKER_TLS_VERIFY=1 \
  ${ANSIBLE_IMAGE_TAG} bash

