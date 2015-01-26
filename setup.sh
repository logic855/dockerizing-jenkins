cat bootmsg.txt
PLUGINS_IMAGE_TAG="flemay/jenkins-plugins"
PLUGINS_CONTAINER_NAME="jenkins-plugins"
PROJECTS_IMAGE_TAG="flemay/jenkins-projects"
PROJECTS_CONTAINER_NAME="jenkins-projects"
JENKINS_IMAGE_TAG="flemay/jenkins"
JENKINS_CONTAINER_NAME="jenkins"

echo "Delete all containers"
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done

echo "Build ${PLUGINS_IMAGE_TAG} image"
docker build -t ${PLUGINS_IMAGE_TAG} jenkins-plugins

echo "Build ${PROJECTS_IMAGE_TAG} image"
docker build -t ${PROJECTS_IMAGE_TAG} jenkins-projects

echo "Build ${JENKINS_IMAGE_TAG} image"
docker build -t ${JENKINS_IMAGE_TAG} jenkins
#docker build --no-cache --rm=true -t "digitalmedia/jenkins" jenkins

echo "Create ${PLUGINS_CONTAINER_NAME} based on ${PLUGINS_IMAGE_TAG}"
docker run --name ${PLUGINS_CONTAINER_NAME} ${PLUGINS_IMAGE_TAG} ls /opt/plugins

echo "Create ${PROJECTS_CONTAINER_NAME} based on ${PROJECTS_IMAGE_TAG}"
docker run --name ${PROJECTS_CONTAINER_NAME} ${PROJECTS_IMAGE_TAG} ls /opt/projects

echo "Run a container with flemay/jenkins image"
# -v $PWD/jenkins-plugins/:/opt/jenkins/data/plugins:rw \
#  -v $PWD/jenkins-jobs/:/opt/jenkins/data/jobs:rw \
docker run \
  -p 8080:8080 \
  --name ${JENKINS_CONTAINER_NAME} \
  --privileged \
  -d \
  --volumes-from ${PLUGINS_CONTAINER_NAME} \
  --volumes-from ${PROJECTS_CONTAINER_NAME} \
  ${JENKINS_IMAGE_TAG}

echo "Wait 15 seconds to let Jenkins boots"
sleep 15

echo "Open Jenkins in a browser"
open http://$(boot2docker ip 2>/dev/null):8080
