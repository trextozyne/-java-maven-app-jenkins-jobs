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
                        sh 'scp $keyfile ec2-user@3.14.253.166:/root/ssh-key.pem' // "from ansible.cfg"
                    }
                }
            }
        }
    }
    stage('execute ansible playbook') {
        steps {
            script {
                echo "executing ansible playbook to configure ec2 instances" // need plugin to enable connecting to remote server(Jenkins) called "ssh-pipeline-steps""
                // remote receives an object i.e hostname, ipaddress, user, private-key etc
                def remote = [:]
                remote.name = "ansible-server"
                remote.host = "3.14.253.166"
                remote.allowAnyHosts = true

                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                    remote.user = user
                    remote.identityFile = keyfile
                    sshCommand remote: remote, command: "ls -lrt"
                }


            }
        }
    }
  }
}
