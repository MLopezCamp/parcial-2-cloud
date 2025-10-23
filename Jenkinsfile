pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        DOCKERHUB_USER = "mlopezcamp"          
        IMAGE_NAME = "parcial2-punto1"         
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Clonar repositorio') {
            steps {
                echo "📥 Clonando el repositorio desde GitHub..."
                checkout scm
            }
        }

        stage('Construir imagen Docker') {
            steps {
                echo "🔨 Construyendo imagen Docker..."
                script {
                    sh """
                        docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Iniciar sesión en DockerHub') {
            steps {
                echo "🔑 Iniciando sesión en DockerHub..."
                script {
                    sh """
                        echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                    """
                }
            }
        }

        stage('Subir imagen a DockerHub') {
            steps {
                echo "⬆️ Subiendo imagen a DockerHub..."
                script {
                    sh """
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completado con éxito. Imagen subida a DockerHub."
        }
        failure {
            echo "❌ Error en la construcción o subida de la imagen."
        }
    }
}
