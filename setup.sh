cat bootmsg.txt
PLUGINS_IMAGE_TAG="flemay/jenkinsplugins"
PLUGINS_CONTAINER_NAME="jenkinsplugins"
JENKINS_IMAGE_TAG="flemay/jenkins"
JENKINS_CONTAINER_NAME="jenkins"

echo "Delete all containers"
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done

echo "Build ${PLUGINS_IMAGE_TAG} image"
docker build -t ${PLUGINS_IMAGE_TAG} jenkins-plugins

echo "Build ${JENKINS_IMAGE_TAG} image"
docker build -t ${JENKINS_IMAGE_TAG} jenkins
#docker build --no-cache --rm=true -t "digitalmedia/jenkins" jenkins

echo "Stop/remove container flemay/jenkins image"
docker stop ${JENKINS_CONTAINER_NAME}
docker rm ${JENKINS_CONTAINER_NAME}

echo "Create ${PLUGINS_CONTAINER_NAME} based on ${PLUGINS_IMAGE_TAG}"
docker run --name ${PLUGINS_CONTAINER_NAME} ${PLUGINS_IMAGE_TAG} ls /opt/jenkins/data/plugins

echo "Run a container with flemay/jenkins image"
# -v $PWD/jenkins-plugins/:/opt/jenkins/data/plugins:rw \
docker run \
  -v $PWD/jenkins-jobs/:/opt/jenkins/data/jobs:rw \
  -p 8080:8080 \
  --name ${JENKINS_CONTAINER_NAME} \
  --privileged \
  -d \
  --volumes-from ${PLUGINS_CONTAINER_NAME} \
  ${JENKINS_IMAGE_TAG}

echo "Wait 20 seconds to let Jenkins boots"
sleep 20

echo "Open Jenkins in a browser"
open http://$(boot2docker ip 2>/dev/null):8080
