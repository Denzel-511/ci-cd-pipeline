pipeline {
     agent any

     environment {
       DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
       DOCKERHUB_USERNAME = 'denzelansah511'
     }

     stages {
       stage('Clone Repository') {
         steps {
           git branch: 'master', url: 'https://github.com/Denzel-511/ci-cd-pipeline.git'
         }
       }

       stage('Build Docker Image') {
         steps {
           script {
             dockerImage = docker.build("${DOCKERHUB_USERNAME}/cicdapp:${env.BUILD_NUMBER}")
           }
         }
       }

       stage('Security Check') {
         steps {
           script {
             withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
               docker.image('snyk/snyk:linux').inside('--entrypoint=""') {
                 sh 'snyk auth $SNYK_TOKEN'
                 sh 'snyk test || true'
               }
             }
           }
         }
       }

       stage('Push Docker Image to DockerHub') {
         steps {
           script {
             docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
               dockerImage.push("${env.BUILD_NUMBER}")
               dockerImage.push('latest')
             }
           }
         }
       }

       stage('Deploy') {
         steps {
           script {
             sh 'echo "Deploying the web app..."'
             // Add your actual deployment steps here
           }
         }
       }
     }

     post {
       success {
         echo 'Pipeline succeeded!'
       }
       failure {
         echo 'Pipeline failed. Please check the logs for details.'
       }
       always {
         cleanWs()
       }
     }
   }
   ```