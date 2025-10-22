pipeline {
    agent any

    environment {
        // Cambia esto por tu usuario Docker Hub y nombre de imagen
        DOCKERHUB_USER = 'mlopezcamp'
        IMAGE_NAME = 'parcial2-punto1'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Clonar repositorio') {
            steps {
                git branch: 'main', url: 'https://github.com/MLopezCamp/parcial-2-cloud.git'
            }
        }

        stage('Construir imagen Docker') {
            steps {
                script {
                    echo "Construyendo imagen Docker..."
                    sh """
                    docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Iniciar sesión en DockerHub') {
            steps {
                script {
                    echo "Iniciando sesión en Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                    }
                }
            }
        }

        stage('Subir imagen a DockerHub') {
            steps {
                script {
                    echo "Subiendo imagen al DockerHub..."
                    sh """
                    docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Imagen subida correctamente a Docker Hub: ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo "❌ Error durante la construcción o subida de la imagen."
        }
        always {
            echo "Pipeline finalizado."
        }
    }
}
