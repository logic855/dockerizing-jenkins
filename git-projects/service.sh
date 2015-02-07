#!/bin/bash
PROJECTS_REPO=git@github.com:flemay/dockerized-jenkins-projects.git

ACTION=$1

if [ "$1" == "clone" ]
then
  echo "cloning ${PROJECTS_REPO}"
  git clone ${PROJECTS_REPO}
elif [ "${ACTION}" == "push" ]
then
  echo "push"
else
  echo "USAGE: $0 clone|push>"
  exit 1
fi
