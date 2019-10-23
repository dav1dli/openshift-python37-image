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
    imgName = 'ocp-python37-image'
    projectName = 'sonarqube'
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
            openshift.withProject(projectName) {
              return !openshift.selector("bc", imgName).exists();
            }
          }
        }
      }
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject(projectName) {
              openshift.newBuild("--name=${imgName}", "--strategy docker")
            }
          }
        }
      }
    }
    stage('Build') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject(projectName) {
              openshift.selector("bc", "${imgName}").startBuild("--from-dir=.", "--wait=true")
            }
          }
        }
      }
    }
  }
}
