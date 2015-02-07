#!/bin/bash
PROJECTS_REPO=git@github.com:flemay/dockerized-jenkins-projects.git

ACTION=$1

if [ "$1" == "clone" ]
then
  echo "cloning ${PROJECTS_REPO}"
  git clone ${PROJECTS_REPO}
elif [ "${ACTION}" == "push" ]
then
  if [ "${2}" == "" ]
    then
    echo "ERROR push needs a commit message"
    exit 1
  fi
  echo "push"
  cd dockerized-jenkins-projects
  git add .
  git commit -m ${2}
  git push origin master
else
  echo "USAGE: $0 [clone|push COMMIT_MSG]"
  exit 1
fi
