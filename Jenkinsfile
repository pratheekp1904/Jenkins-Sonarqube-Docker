pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-southeast-1'                // AWS region
        ECR_REPO = 'mywebsite'                    // ECR repository name
        IMAGE_TAG = 'latest'
        CLUSTER_NAME = 'my-cluster'      // Your EKS cluster name
        ECR_URL = "626635410898.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        SONARQUBE_URL = 'http://54.169.131.59:9000' // URL of your SonarQube server
        SONARQUBE_AUTH = credentials('sqa_50d0bc82c65db8e7df7c757cfe7ac59f5c257bbb') // SonarQube authentication token
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/pratheekp1904/Jenkins-Sonarqube-Docker.git'
            }
        }

        stage('Code Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    sh '''
                    mvn sonar:sonar \
                        -Dsonar.host.url=${SONARQUBE_URL} \
                        -Dsonar.login=${SONARQUBE_AUTH}
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${ECR_URL}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URL}'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh 'docker push ${ECR_URL}:${IMAGE_TAG}'
                }
            }
        }

        stage('Update Kubernetes Deployment') {
            steps {
                script {
                    // Update the Kubernetes deployment with the new image
                    sh '''
                    kubectl set image deployment/my-static-site my-static-site=${ECR_URL}:${IMAGE_TAG} --record
                    kubectl rollout status deployment/my-static-site
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
