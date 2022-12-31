pipeline {
  agent any
  parameters {
    choice(name: 'VERSION', Choices: ['1.1.0', '1.2.0','1.3.0'], description: '')
    booleanParam(name: 'executeTests', defaultValue: true, description: '')
  }
  stages {
    stage('Build') {
      steps {
        echo 'Building...'
        // build steps go here
      }
    }
    stage('Test') {
        when {
            expression {
              params.executeTests
            }
        }
      steps {
        echo 'Testing...'
        // test steps go here
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying...'
        echo "deploying version ${params.VERSION}"
        // deploy steps go here
      }
    }
  }
}
