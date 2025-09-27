pipeline {
    agent { label 'docker' }

    environment {
        GIT_URL = 'https://github.com/JLASOT/policy_as_code_labs.git'
        GIT_CREDENTIALS = 'git-credentials-id' 
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                git branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS}",
                    url: "${GIT_URL}"
            }
        }

        stage('Policy Check - Conftest') {
            steps {
                echo "Running Conftest in Docker..."
                sh '''
                    docker run --rm \
                        -v ${PWD}:/project \
                        -w /project \
                        openpolicyagent/conftest \
                        test --policy lab1-conftest/policies \
                             lab1-conftest/manifests/deployment-insecure.yaml
                '''
            }
        }

        stage('Policy Check - Checkov') {
            steps {
                echo "Running Checkov in Docker..."
                sh '''
                    docker run --rm \
                        -v ${PWD}:/project \
                        -w /project \
                        bridgecrew/checkov \
                        -d lab2-checkov/terraform
                '''
            }
        }
    }

    post {
        always {
            echo 'Policy checks completed'
        }
    }
}
