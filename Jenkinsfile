#!/usr/bin/env groovy

CODE_CHANGE = getGitChanges()
pipeline {
  agent any
  parameters {
    // string(name: 'VERSION', defaultValue: '', description: 'Version to deploy on Prod Server') //OR
    choice(name: 'VERSION', choices: ['1.1.0', '1.2.0','1.3.0'], description: '')
    booleanParam(name: 'executeTests', defaultValue: true, description: '')
  }
  tools {
    //For acces to JENKINS tolls, supports 3 types: Gradle, Mave, and JDK
    maven 'Maven' // Find name goto Global tools Configuration and click the drop down on the package chose the name
  }
  environment {
    NEW_VERSION = '1.3.0'
    // SERVER_CREDENTIALS = credentials('github-credentials') //need to install pugin in JENKINS to allow i.e Credentials Plugin
  }
  stages {
    stage('Build') {
      steps {
        script {
          def var = getVar
        }
        echo "Building..."
        echo "Building version ${NEW_VERSION}"
        sh "mvn install" //use tool like this
        // build steps go here
      }
    }
    stage('Test') {
        when {
            expression {
                # find all this variables in  http://JENKINS_URL:8080/env-vars.html/
                (env.BRANCH_NAME == 'dev' || BRANCH_NAME == 'master') && CODE_CHANGE == true && params.executeTests
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
        withCredentials([
          usernamePassword(credentials: 'github-credentials', usernameVariable: USER, passwordVariable: PWD)
        ]) {
              sh 'git clone https://$USER:$PWD@github.com/user/repo.git'  //'"git clone https://${USER}:${PWD}@github.com/user/repo.git"
        }
        // echo "deploying with ${SERVER_CREDENTIALS}"
        // sh "${SERVER_CREDENTIALS}"
        // deploy steps go here
      }
    }
  }
}
