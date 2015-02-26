#!/bin/bash
PROJECTS_REPO=git@github.com:flemay/dockerized-jenkins-projects.git

function download {
  ansible-playbook -v /opt/playbooks/download.yml
}

function upload {
  msg=$1
  if [ "${msg}" == "" ]
    then
    echo "ERROR push needs a commit message"
    exit 1
  fi
  ansible-playbook -v /opt/playbooks/upload.yml --extra-vars "commit_msg='$msg'"
}

command=$1
case "$command" in
  download)
    download
    ;;
  upload)
    upload "$2"
    ;;
  *)
    echo $"Usage: $0 {download|upload} [<args>]"
    exit 1
esac


