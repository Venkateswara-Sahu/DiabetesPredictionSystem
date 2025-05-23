pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'riverstead/diabetes-prediction:latest'
        DOCKER_CLIENT_TIMEOUT = '300'
        COMPOSE_HTTP_TIMEOUT = '300'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Venkateswara-Sahu/DiabetesPredictionSystem.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    withEnv(["DOCKER_CLIENT_TIMEOUT=${DOCKER_CLIENT_TIMEOUT}", "COMPOSE_HTTP_TIMEOUT=${COMPOSE_HTTP_TIMEOUT}"]) {
                        docker.build("${DOCKER_IMAGE}")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat """
                            echo Logging in to Docker Hub...
                            docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                            docker push ${DOCKER_IMAGE}
                        """
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    bat "docker run -d -p 5000:5000 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        success {
            mail to: 'venkateswarsahu000@gmail.com',
                 subject: "✅ Build was a Success - #${env.BUILD_NUMBER}",
                 body: "Diabetes Prediction pipeline ran successfully!"
        }
        failure {
            mail to: 'venkateswarsahu000@gmail.com',
                 subject: "❌ Build has Failed - #${env.BUILD_NUMBER}",
                 body: "Pipeline failed. Please check Jenkins logs."
        }
    }
}
