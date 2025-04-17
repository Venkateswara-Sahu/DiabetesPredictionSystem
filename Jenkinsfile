pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'diabetes-prediction:latest'
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

        stage('Run Container') {
            steps {
                script {
                    bat 'docker run -d -p 5000:5000 diabetes-prediction'
                }
            }
        }
    }

    post {
        success {
            mail to: 'venkateswarsahu000@gmail.com',
                 subject: "✅ Build Success - #${env.BUILD_NUMBER}",
                 body: "Diabetes Prediction pipeline ran successfully!"
        }
        failure {
            mail to: 'venkateswarsahu000@gmail.com',
                 subject: "❌ Build Failed - #${env.BUILD_NUMBER}",
                 body: "Pipeline failed. Please check Jenkins logs."
        }
    }
}
