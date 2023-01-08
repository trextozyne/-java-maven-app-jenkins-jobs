pipeline {
    agent any
    stages {
        stage('copy files to ansible server') {
            steps {
                script {
                    echo 'copying all necessary files to ansible control node'
                    sshagent(['ansible-server-key']) {

                        if (sh(script: "ssh ec2-user@3.14.253.166 'test -f ~/ssh-key.pem}'", returnStatus: true) == 0) {
                            sh "ssh ec2-user@3.14.253.166 'chmod 777 ~/ssh-key.pem'"
                        }

                        sh 'scp -vvv -o StrictHostKeyChecking=no ansible/* ec2-user@3.14.253.166:~/'

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile $user@3.14.253.166:~/ssh-key.pem' // "from ansible.cfg"

//                            def python_output = sh(script: 'ssh -i $keyfile $user@3.14.253.166 "python3 -V"', returnStdout: true)
//                            def python_output = sh(script: 'ssh $user@3.14.253.166 "python3 -V"', returnStdout: true).trim()
//                            def major_minor_version = python_output.split(' ')[1].split('\\.')[0..1].join('.')
//
//                            def PYTHON_VERSION = major_minor_version
//
//                            def boto3 = "/usr/lib/python${PYTHON_VERSION}/site-packages/boto3"
//                            def botocore = "/usr/lib/python${PYTHON_VERSION}/site-packages/botocore"
//
//                            def local_boto3 = "/usr/local/lib/python${PYTHON_VERSION}/site-packages/boto3"
//                            def local_botocore = "/usr/local/lib/python${PYTHON_VERSION}/site-packages/botocore"
//
//                            if (sh(script: "ssh ec2-user@3.14.253.166 'test -f ${boto3}'", returnStatus: true) == 1 && sh(script: "ssh ec2-user@3.14.253.166 'test -f ${botocore}'", returnStatus: true) == 1) {
//
//                                def scp_cmd_boto3 = "sudo scp -r ${local_boto3} /usr/lib/python${PYTHON_VERSION}/site-packages/"
//                                def scp_cmd_botocore = "sudo scp -r ${local_botocore} /usr/lib/python${PYTHON_VERSION}/site-packages/"
//
//                                sh 'ssh -i $keyfile ec2-user@3.14.253.166 ' + scp_cmd_boto3
//                                sh 'ssh -i $keyfile ec2-user@3.14.253.166 ' + scp_cmd_botocore
//                            }
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
//        stage("set ~/ssh-key.pem permissions to 600") {
//            steps {
//                script {
//                    sh "ssh ec2-user@3.14.253.166 'sudo chmod 600 ~/ssh-key.pem'"
//                }
//            }
//        }
    }
}
