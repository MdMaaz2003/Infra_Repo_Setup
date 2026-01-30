pipeline {
    agent any

    environment {
        IMAGE_NAME = "react-frontend"
        CONTAINER_NAME = "react-frontend-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat """
                docker build -t %IMAGE_NAME% .
                """
            }
        }

        stage('Stop Old Container (if exists)') {
            steps {
                bat """
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                """
            }
        }

        stage('Run Container') {
            steps {
                bat """
                docker run -d -p 3000:80 --name %CONTAINER_NAME% %IMAGE_NAME%
                """
            }
        }
    }

    post {
        success {
            echo "React app deployed successfully!"
        }
    }
}

