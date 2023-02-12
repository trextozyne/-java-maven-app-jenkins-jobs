## What this does?
This repo consist of several projects that run in a CI/CD pipeline using JENKINS. Docker is installed on an EC2 instance & Jenkins is installed as a Docker Image.

## Docker installation
Install Docker on the EC2 after Jenkins is installed by following the instructions on https://serverfault.com/questions/836198/how-to-install-docker-on-aws-ec2-instance-with-ami-ce-ee-update

## Jenkins installation
Jenkins is installed as a Docker Image, when building an application there's need to build a Docker image of that application in Jenkins, therefore Docker needs to be available in 
Jenkins. The way to do that is to attach a volume to Jenkins from the host file on the Server(EC2 in this case) itself where Docker is installed hence Docker commands will become
available, next mount docker runtime directories from the Server into the container as a volume. Docker will become available inside the Jenkins container.

1. `docker volume ls`

2. `docker run -p 8080:8080 -p 50000:50000 -d -v jenkin_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:lts`

3. Log into Docker container and provide user with permissions `docker exec -u 0 -it <image_ID> bash`

4. `chmod 666 /var/run/docker.sock`

5. Check the permissions are applied. `ls -l /var/run/docker.sock`

Need some Jenkins Plugins to work, info. on that soon.
