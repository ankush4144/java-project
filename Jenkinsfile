pipeline {
    agent {
        label 'CENTOS_SLAVE'
    }
    
    stages {
        stage('Docker images pull') {
            steps {
                echo 'Pulling Docker Images..'
                sh 'docker version'
                sh 'docker pull maven:3.8.2-openjdk-11'
                sh 'docker pull openjdk:8-jdk-slim'
            }
        }
        stage('Build and Artifact') {
            
            agent{
                  docker {
                        image 'maven:3.8.2-openjdk-11'
                        args '-v $WORKSPACE/java_app:/shared-volume -u root'
                        label 'CENTOS_SLAVE'
                    }
                }
            options {
                skipDefaultCheckout()
            }
            steps {
                echo "Changing Directory"
                sh 'cd /shared-volume'
                echo "Running mvn install on the code"
                sh 'mvn clean install'
                echo 'Creating Artifacts..'
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Printing content of Dockerfile"
                sh 'cat Dockerfile'
                echo "Creating image to run the .jar file"
                sh 'docker build -t jar-executor .'
            }
        }
        stage('Run Docker Container') {
            steps {
                echo "Running the container to see output of .jar file"
                sh 'docker run jar-executor'
            }
        }
        stage('Cleanup') {
            steps {       
                echo "Removing all containers as they are no longer required"
                sh 'docker rm `sudo docker ps -q -a`'
            }
        }
    }
}
