pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
  stages {
    stage('Build') {
      steps {
        // Check current directory and workspace contents
        sh 'pwd'
        sh 'ls -R'

        // Remove unwanted files
        sh 'rm -rf *.war'

        // Check the directory structure for debugging
        sh 'ls -l src/main/webapp'

        // Create the WAR file
        sh 'jar -cvf student.war -C "src/main/webapp/WEB-INF" .'

        // Build Docker image
        sh 'docker build -t satluri2/student-survey-app:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push image to Docker Hub') {
      steps {
        sh 'docker push satluri2/student-survey-app:latest'
      }
    }
    stage('Deploying on Kubernetes') {
      steps {
        sh 'kubectl set image deployment/surveyassign2-deploy container-0=satluri2/student-survey-app:latest -n default'
        sh 'kubectl rollout restart deploy surveyassign2-deploy -n default'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}


