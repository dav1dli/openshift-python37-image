pipeline {
  agent {
    node {
      label 'master'
    }
  }
  options {
    timeout(time: 10, unit: 'MINUTES')
  }
  environment {
    imgName = 'openshift-python37-ubi8'
  }
  stages {
    stage('SCM') {
      steps {
        git url: 'https://github.com/dav1dli/openshift-python37-image.git'
      }
    }
    stage('NewBuild') {
      when {
        expression {
          openshift.withCluster() {
            openshift.withProject() {
              return !openshift.selector("bc", imgName).exists();
            }
          }
        }
      }
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject() {
              openshift.newApp("openshift-python37-ubi8-template.yml")
              openshift.selector("bc", "$imgName").startBuild("--wait=true")
            }
          }
        }
      }
    }
    stage('Build') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject() {
              openshift.selector("bc", "$imgName").startBuild("--wait=true")
            }
          }
        }
      }
    }
    stage('Tag') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject() {
              openshift.tag("${imgName}:v3.11", "${imgName}:latest")
            }
          }
        }
      }
    }
  }
}
