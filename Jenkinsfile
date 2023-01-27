//For this must install following Jenkins
//Amazon EC2 plugin
//Docker plugin
//Docker pipeline plugin
//Github integration plugin also sudo yum install git on EC2
pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('dockerhub')//dockerhub username & pwd in Jenkins
    }
    stages {
        stage('Clone Repo') {
            steps {
                checkout scm //does the cloning of the reposiotry
                sh 'ls *' //once we put github url in jenkins it executes this line
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t tosyne/jenkinstest:$BUILD_NUMBER .' //if code fails because of this $BUILD_NUMBER you need to restart from the first stage, dont replay and start from middle.
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u DOCKERHUB_CREDS_USR --password-stdin'
            }
        }
        stage('Docker Push') {
            steps {
                sh 'docker push tosyne/jenkinstest:$BUILD_NUMBER'
            }
        }
    }
    post {
        always {
        sh 'docker logout'
        }
    }
}

