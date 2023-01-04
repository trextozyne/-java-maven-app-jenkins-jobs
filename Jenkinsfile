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

    stage('build App') {
      steps {
        script {
            groovy.buildApp()
        // build steps go here
        }
      }
    }

    stage('test') {
      steps {
        script {
            groovy.testApp()
            }
        // test steps go here
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

