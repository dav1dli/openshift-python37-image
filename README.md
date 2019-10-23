# Openshift Python 3.7 base image

This image is installed with Python 3.7.x runtime. The purpose is to have a baseline configration running Python apps as services deployed to Openshift. Python 3.7.x is installed from sources.
In the future when python 3.7 will be available as a package from supported repositories this configuration could be simplified.

The configuration uses standard UBI8 image as a baseline. The configuration installs python 3.7 and dependencies required to build it.

# Build the image locally

*Note:* _the process will require login to Red Hat docker registry hosting the base image._
```
docker build -t openshift-python37-ubi8 .
```

# Build the image on Openshift from the command line

```
git clone https://github.com/dav1dli/openshift-python37-jenkins-slave.git .
oc login -u developer
oc project sonarqube
cat Dockerfile | oc new-build --name openshift-python37-ubi8 --dockerfile='-'
```
# Build the image on Openshift using template

```
oc process -f openshift-python37-ubi8-template.yml | oc create -f -
```

# Jenkins build

TBD
