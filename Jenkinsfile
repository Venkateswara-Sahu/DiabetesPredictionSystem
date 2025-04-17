pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'diabetes-prediction:latest'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Venkateswara-Sahu/DiabetesPrediction.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker run --rm -p 5000:5000 ${DOCKER_IMAGE}"
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
