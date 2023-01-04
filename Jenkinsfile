#!/usr/bin/env groovy
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
            groovy.buildJar()
        // build steps go here
        }
      }
    }
    
    stage('build image') {
      steps {
        script {
            groovy.buildImage()
            }
        // test steps go here
        }
    }
    stage('Deploy') {
      steps {
        script {
            groovy.deployAPP()
            // deploy steps go here
        }
      }
    }
  }
}

