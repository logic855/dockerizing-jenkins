Dockerizing Jenkins
==================

Dockerfiles and scripts to dockerize Jenkins.

Pre-requisites
--------------

- docker on the machine that is going to setup Jenkins

Boot2docker and Docker Cheat Sheet
----------------------------------

- to see whether you can connect to Docker Host: `boot2docker ssh`
- `boot2docker init`
- `boot2docker start` (copy and paste the export)
- if you open VirtualBox you will see the docker vm that runs Docker Host
- if you have problem with internet, restart boot2docker `boot2docker restart`
- to delete all containers: `docker rm $(docker ps -a -q)`
- to delete all images: `docker rmi $(docker images -q)`

Images
------

**ansible**: ansible 1.8.4

**ansible-docker**: image based on docker and install ansible. Based on image **docker**.

**docker**: image that installs docker

**git-jenkins**: container that downloads/uploads Jenkins and its plugins. Image needs ssh key to let the container to upload/download to the jenkins repo. The **service.sh** is the entry point of the container.

> A better alternative would be to use S3 because GitHub is not meant to save binaries.

**git-projects**: container that downloads/uploads projects. The ssh key allows access to a projects repository. The **service.sh** is the entry point of the container.

**jenkins**: jenkins container. Image is based on ansible-docker. The folder **jenkins/dockerized-jenkins/** is the repo that contains jenkins and its plugins. The image adds it while being built.

**jenkins-data**: It creates a data place holder for Jenkins projects. This is a data container. This is where `git-projects` will download and uplaad the projects from.

Scenarios
----------

### Setup Jenkins from current images

In this scenario, Jenkins will be up and running for the first time.

#### bootstrap.sh

It is the script that will set up the necessary. It creates an environment that you will be able to run the playbook to setup Jenkins. It will

1. delete all containers
2. build docker image
3. build ansible image
4. build ansible image
5. build ansible-docker image
6. create a container from ansible-docker image named `ansible-bootstrap`

`ansible-bootstrap` is the first container to be created. It has access to:

- playbooks folder (setup.yml)
- images folder
- certificate path from my host to access my Docker Host
> This is not best practice but serve the demo purpose. @TODO what would be the best practice
- docker host tcp address

Once `bootstrap.sh` has been executed, a container will be running and you will be able to execute `ansible`!

#### setup.yml

This playbook sets up Jenkins. So it will:

1. build the required images
2. create data container `jenkins-data`
3. pull the projects with the container `git-jenkins`
4. create Jenkins container that will have access to Docker Host

To run the playbook: `ansible-playbook setup.yml`

Jenkins should now be running on port 8080.

### Update Jenkins Jobs

Jenkins has a job named `Save-Projects` which saves projects and configuration. It does not save the history of the jobs.

Here's what the job command shell looks like:

```
ansible-playbook -v /opt/playbooks/git-projects-upload.yml -e "commit_msg='[$JOB_NAME - $BUILD_NUMBER] This is an automatic commit from Jenkins'"
```

It calls one of the Jenkins playbooks to commit and push the projects. `git-projects-upload.yml` creates a container from `git-projects` image and delegates the task to it.

### Update Jenkins Versions

`Save-Jenkins-And-Plugins` is a Jenkins job to commit and push any changes related to Jenkins version and plugins.

```
ansible-playbook -v /opt/playbooks/git-jenkins-upload.yml -e "commit_msg='[$JOB_NAME - $BUILD_NUMBER] This is an automatic commit from Jenkins'"
```

It calls a Jenkins playbook `git-jenkins-upload.yml` to do the work. `git-jenkins-upload.yml` creates a container from `git-jenkins` image and delegates the task to it.

What could be next?
-------------------

- The jobs could be ran every X minutes
- 
