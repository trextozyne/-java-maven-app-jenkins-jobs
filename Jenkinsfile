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
            buildImage()
        }
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