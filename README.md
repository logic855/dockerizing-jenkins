Dockerized Jenkins
==================

This repo contains one way of dockerizing Jenkins.

Overview
--------

Jenkins has been broken down into 3 containers:

- data container for plugins
- data container for projects and config
- container running Jenkins

The 2 data containers are independent of Jenkins container. So they do not know where is the Jenkins' path. Therefore, Jenkins container needs to symlink the 2 data containers.

Scenarios
---------

This section contains different scenarios

### Updating Jenkins version

### Adding new plugins

### Adding new jobs