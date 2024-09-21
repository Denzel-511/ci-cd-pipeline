pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')  // Your DockerHub credentials stored in Jenkins
  }

  stages {

    // Step 1: Clone the repository from GitHub
    stage('Clone Repository') {
      steps {
        git branch: 'main', url: 'https://github.com/Denzel-511/ci-cd-pipeline.git'
      }
    }

    // Step 2: Build the Docker Image
    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build('cicdapp')  // Builds Docker image using the Dockerfile in your repository
        }
      }
    }

    // Step 3: Security Check using Snyk
    stage('Security Check') {
      steps {
        sh 'snyk test'  // Runs security scan with Snyk to check for vulnerabilities
      }
    }

    // Step 4: Push Docker Image to DockerHub
    stage('Push Docker Image to DockerHub') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
            dockerImage.push('latest')  // Pushes Docker image to DockerHub with 'latest' tag
          }
        }
      }
    }

    // Step 5: Deploy (Simulated) - You can customize this for your deployment process
    stage('Deploy') {
      steps {
        script {
          sh 'echo "Deploying the web app..."'
          // You can add real deployment steps if you have a target environment
        }
      }
    }
  }

  post {
    always {
      cleanWs()  // Clean up workspace after job completion
    }
  }
}