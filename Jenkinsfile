pipeline {
    agent any
    stages {
        stage('copy files to ansible server') {
            steps {
                script {
                    echo 'copying all necessary files to ansible control node'
                    sshagent(['ansible-server-key']) {
                        def python_output = sh(script: 'python3 -V', returnStdout: true)
                        def python_version = python_output.split()[1]
                        def major_minor_version = python_version.split('.')[0..1].join('.')

                        def PYTHON_VERSION = major_minor_version
                        def boto3 = "/usr/lib/${PYTHON_VERSION}/site-packages/boto3"
                        def botocore = "/usr/lib/${PYTHON_VERSION}/site-packages/botocore"
                        if(sh(returnStatus: false, script: "test -f :${boto3}") && sh(returnStatus: false, script: "test -f :${botocore}")) {
                            sh "ssh ec2-user@3.14.253.166 'cp /usr/local/lib/python${PYTHON_VERSION}/site-packages/${boto3} /usr/lib/python${PYTHON_VERSION}/site-packages/'"

                            sh "ssh ec2-user@3.14.253.166 'cp /usr/local/lib/python${PYTHON_VERSION}/site-packages/${botocore} /usr/lib/python${PYTHON_VERSION}/site-packages/'"
                        }

                        if (sh(returnStatus: true, script: "test -f :~/ssh-key.pem")) {
                            sh "ssh ec2-user@3.14.253.166 'chmod 777 ~/ssh-key.pem'"
                        }

                        sh 'scp -vvv -o StrictHostKeyChecking=no ansible/* ec2-user@3.14.253.166:~/'

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile ec2-user@3.14.253.166:~/ssh-key.pem' // "from ansible.cfg"
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
                    remote.host = "3.14.253.166"
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
        stage("set ~/ssh-key.pem permissions to 600") {
            steps {
                script {
                    sh "ssh ec2-user@3.14.253.166 'sudo chmod 600 ~/ssh-key.pem'"
                }
            }
        }
    }
}
