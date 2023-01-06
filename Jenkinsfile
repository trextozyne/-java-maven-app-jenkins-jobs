pipeline {
  agent any
  stages {
    stage('copy files to ansible server') {
        steps {
            script {
                echo 'copying all necessary files to ansible control node'
                sshagent(['ansible-server-key']) {
                    sh 'scp -vvv -o StrictHostKeyChecking=no ansible/* ec2-user@3.14.253.166:/root'

                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                        sh "scp ${keyfile} ec2-user@3.14.253.166:/root/ssh-key.pem" // from ansible.cfg
                    }
                }
            }
        }
    }
  }
}
