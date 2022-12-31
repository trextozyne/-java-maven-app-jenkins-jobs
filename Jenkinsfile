
pipeline {
  agent none
  stages {
    stage('test') {
      steps {
        script {
            echo 'Testing the application...'
            echo 'executing pipeline for $BRANCH_NAME'
        }
    }
    stage('build') {
        when {
            expression {
                BRANCH_NAME = 'master'  //variable only available i nmulti-branch setup
            }
        }
      steps {
        script {
            echo 'Building the application...'
        }
      }
    }
    stage('Deploy') {
        when {
            expression {
                BRANCH_NAME = 'master'  //variable only available i nmulti-branch setup
            }
        }
      steps {
        script {
            echo 'Deploying the application...'
        }
      }
    }
  }
}
