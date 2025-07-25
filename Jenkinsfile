#!usr/bin/env groovy
pipeline {
    agent any
    tools{
        maven 'maven-3.6'
    }
    environment{
        IMAGE_NAME = "tenguhh/automated-build-deploy-java:java-maven-app-1.0"
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',usernameVariable: 'DOCKER_USER',passwordVariable: 'DOCKER_PASS')]) {
    
       sh'''
       sudo echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
       sudo docker build -t $IMAGE_NAME .
       sudo docker push $IMAGE_NAME
       '''
}

                }
            }
        }
    }
    
}