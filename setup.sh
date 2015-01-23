JENKINS_CONTAINER_NAME="jenkins"

echo "Build Jenkins image"
docker build -t "flemay/jenkins" jenkins
#docker build --no-cache --rm=true -t "digitalmedia/jenkins" jenkins

echo "Stop/remove container flemay/jenkins image"
docker stop ${JENKINS_CONTAINER_NAME}
docker rm ${JENKINS_CONTAINER_NAME}

echo "Run a container with flemay/jenkins image"
# -v $PWD/jenkins-plugins/:/opt/jenkins/data/plugins:rw \
# Adding a volume for jenkins-plugins does not work well
# and I have no idea why
# It takes a long time to boot jenkins and I cannot install
# any plugins
docker run \
  -v $PWD/jenkins-jobs/:/opt/jenkins/data/jobs:rw \
  -v $PWD/jenkins-plugins/:/opt/jenkins/data/plugins:rw \
  -p 8080:8080 \
  --name ${JENKINS_CONTAINER_NAME} \
  --privileged \
  -d digitalmedia/jenkins

echo "Wait 20 seconds to let Jenkins boots"
sleep 20

echo "Open Jenkins in a browser"
open http://$(boot2docker ip 2>/dev/null):8080
