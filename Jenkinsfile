#!/usr/bin/env groovy

// Only used for Poject Scoped Shared Library occassion when we dont have a global shared library defind in Jenkins
        // Library identifier:  'jenkins-shared-library@masster', retrieve: moderSCM(
        //         [$class: 'GitSCMSource',
        //          remote: 'https://github.com/trextozyne/jenkins-shared-library.git',
        //           credentialsId: 'github-credentials']
        // )
// Only used for Poject Scoped Shared Library occassion when we dont have a global shared library defind in Jenkins


@Library('jenkins-shared-library@2.0')

@Library('jenkins-shared-library')//_ use it if no variable definition is defined afetr, its used for seperation from pipeline
def groovy

pipeline {
  agent any
  tools{
    maven 'Maven'
  }
  stages {
    stage('init') {
      steps {
        script {
          groovy = load 'script.groovy'
        }
      }
    }

    stage('build jar') {
      steps {
        script {
            buildJar()
        }
      }
    }

    stage('build image') {
      steps {
        script {
            buildImage 'trex1987/my-repo:jma-3.0'
            dockerLogin()
            dockerPush 'trex1987/my-repo:jma-3.0'
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
            groovy.deployApp()
            // deploy steps go here
        }
      }
    }
  }
}