pipeline {
    agent {
        label 'CENTOS_SLAVE'
    }
    
    stages {
        stage('Docker images pull') {
            steps {
                echo 'Pulling Docker Images..'
                sh 'sudo docker version'
                sh 'sudo docker pull maven:3.8.2-openjdk-11'
                sh 'sudo docker pull openjdk:8-jdk-slim'
            }
        }
        stage('Build and Artifact') {
            steps {
                echo "Running docker container for building code"
                sh 'sudo docker run -v `pwd`:/shared-volume maven:3.8.2-openjdk-11 mvn -f /shared-volume clean install'
                echo "Printing structure of current directory"
                sh 'tree'
                echo 'Creating Artifacts..'
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Printing content of Dockerfile"
                sh 'cat Dockerfile'
                echo "Creating image to run the .jar file"
                sh 'sudo docker build -t jar-executor .'
            }
        }
        stage('Run Docker Container') {
            steps {
                echo "Running the container to see output of .jar file"
                sh 'sudo docker run jar-executor'
            }
        }
        stage('Cleanup') {
            steps {       
                echo "Removing all containers as they are no longer required"
                sh 'sudo docker rm `sudo docker ps -q -a`'
            }
        }
    }
}
