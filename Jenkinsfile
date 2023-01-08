pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "3.14.253.166"
    }
    stages {
        stage('copy files to ansible server') {
            steps {
                script {
                    echo 'copying all necessary files to ansible control node'
                    sshagent(['ansible-server-key']) {

                        sh 'scp -vvv -o StrictHostKeyChecking=no ansible/* ec2-user@$ANSIBLE_SERVER:~/'

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            if (sh(script: "ssh ec2-user@${ANSIBLE_SERVER} 'test -f ~/ssh-key.pem'", returnStatus: true) != 0) {
                                sh 'scp $keyfile $user@$ANSIBLE_SERVER:~/ssh-key.pem' // "from ansible.cfg"
                            }
                        }
                    }
                }
            }
        }
        stage('execute ansible playbook') {
            steps {
                script {
                    echo "executing ansible playbook to configure ec2 instances"
                    // need plugin to enable connecting to remote server(Jenkins) called "ssh-pipeline-steps""
                    // remote receives an object i.e hostname, ipaddress, user, private-key etc
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = env.ANSIBLE_SERVER
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile = keyfile
                        sshCommand remote: remote, command: "ls -l"
//                    sshCommand remote: remote, command: "export ANSIBLE_CONFIG=ansible.cfg"
                        sshCommand remote: remote, command: "ansible-playbook ~/my-playbook.yaml"
                    }
                }
            }
        }
    }
}
