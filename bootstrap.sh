#!/bin/bash

echo "Delete all containers"
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done

echo "Build docker image"
docker build -t flemay/docker images/docker

echo "Build ansible-docker image"
docker build -t flemay/ansible-docker images/ansible-docker

echo "Run a container with flemay/ansible-docker image"
docker run \
  -it \
  --name ansible-bootstrap \
  -v $(pwd)/playbooks:/opt/ansible/playbooks \
  -v $(pwd)/images:/opt/ansible/images:ro \
  -v $(echo $DOCKER_CERT_PATH):/root/.docker:ro \
  -e DOCKER_HOST=tcp://$(boot2docker ip):2376 \
  -e DOCKER_TLS_VERIFY=1 \
  flemay/ansible-docker bash
