#!/bin/bash
PROJECTS_REPO=git@github.com:flemay/dockerized-jenkins-projects.git

function clone {
  #echo "Clone ${PROJECTS_REPO}"
  #git clone ${PROJECTS_REPO}
  ansible-playbook -v /opt/playbooks/clone.yml
}

function push {
  msg=$1
  if [ "${msg}" == "" ]
    then
    echo "ERROR push needs a commit message"
    exit 1
  fi
  echo "Add changes, commit and push to ${PROJECTS_REPO}"
  cd dockerized-jenkins-projects
  git add --all
  git commit -m "${1}"
  git push origin master
}

command=$1
case "$command" in
  clone)
    clone
    ;;
  push)
    push $2
    ;;
  *)
    echo $"Usage: $0 {clone|push} [<args>]"
    exit 1
esac


