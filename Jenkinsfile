
pipeline {
  agent any
  parameters {
    choice(name: 'VERSION', choices: ['1.1.0', '1.2.0','1.3.0'], description: '')
    booleanParam(name: 'executeTests', defaultValue: true, description: '')
  }
  stages {
    stage('init') {
      steps {
        script {
          groovy = load "script,groovy"
        }
      }
    }
    stage('Build') {
      steps {
        script {
          groovy.buildApp
        }
      }
    }
    stage('Test') {
        when {
            expression {
              params.executeTests
            }
        }
      steps {
        script {
          groovy.testApp
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
          groovy.deployApp
        }
        // deploy steps go here
      }
    }
  }
}
