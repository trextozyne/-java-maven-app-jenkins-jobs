pipeline {
  agent any
  tools{
    maven 'Maven'
  }
  stages {
    stage('build jar') {
      steps {
        script {
            echo 'Building...'
            sh 'mvn package'
        // build steps go here
        }
      }
    }
    stage('build image') {
      steps {
        script {
            echo 'Testing...'
            withCredentials([usernamePassword(credentialsId: '	Dockerhub-repo',passwordVariable: 'PASSWD', usernameVariable: 'USER')]) {
                sh 'docker build -t trex1987/my-repo:jma-2.0 .'
                sh 'echo #PASSWD | docker login -u USER --password-stdin'
                sh 'docker push trex1987/my-repo:jma-2.0'
            }
        // test steps go here
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
            echo 'Deploying...'
            // deploy steps go here
        }
      }
    }
  }
}
