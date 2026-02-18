pipeline {
    agent any

    environment {
        IMAGE_NAME = "oussemaguerami/mon-app-devops"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/oussama-grami/jenkins.git'

            }
        }

        stage('Tests') {
    agent {
        docker { image 'python:3.10' }
    }
    steps {
        sh 'pip install -r requirements.txt'
        sh 'python -m unittest discover || true'
    }
}


        stage('Build Image') {
            steps {
                sh "docker build -t $IMAGE_NAME:${BUILD_NUMBER} ."
                sh "docker tag $IMAGE_NAME:${BUILD_NUMBER} $IMAGE_NAME:latest"
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {

                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push $IMAGE_NAME:${BUILD_NUMBER}"
                    sh "docker push $IMAGE_NAME:latest"
                }
            }
        }
    }
}
