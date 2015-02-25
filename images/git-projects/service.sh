#!/bin/bash
PROJECTS_REPO=git@github.com:flemay/dockerized-jenkins-projects.git

function clone {
  ansible-playbook -v /opt/playbooks/clone.yml
}

function push {
  msg=$1
  if [ "${msg}" == "" ]
    then
    echo "ERROR push needs a commit message"
    exit 1
  fi
  ansible-playbook -v /opt/playbooks/push.yml --extra-vars "commit_msg='$msg'"
}

command=$1
case "$command" in
  clone)
    clone
    ;;
  push)
    push "$2"
    ;;
  *)
    echo $"Usage: $0 {clone|push} [<args>]"
    exit 1
esac


