#!/usr/bin/env groovy

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