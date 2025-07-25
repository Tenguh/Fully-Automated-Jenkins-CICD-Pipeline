#!usr/bin/env groovy
pipeline {
    agent any
    tools{
        maven 'maven-3.6'
    }
    environment{
        IMAGE_NAME = "tenguhh/automated-build-deploy-java:java-maven-app-1.0 ."
    }
    stages{
        stage("build app"){
            steps{
                script{
                    echo"building the application"
                    sh "mvn clean package" 
                    echo "Building the Application..."
                }
            }
        }
        stage("Docker Image"){
            steps{
                script{
                    echo "Building the Docker Image..."
                    sh "sudo usermod -aG docker jenkins"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',usernameVariable: 'DOCKER_USER',passwordVariable: 'DOCKER_PASS')]) {
    
       sh "echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin"
       sh "docker build -t $IMAGE_NAME"
       sh "docker push $IMAGE_NAME"
    
}

                }
            }
        }
    }
    
}