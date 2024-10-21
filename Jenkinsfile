pipeline{
  agent any
  environment {
              DOCKERHUB_CREDENTIALS=credentials('dockerhub')
  }
  stages{
    stage('Build') {
      steps {
        sh 'rm -rf *.var'
        sh 'jar -cvf student.war -C "student/src/main/webapp" .'
        sh 'docker build -t satluri2/student-survey-app:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW |docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage("Push image to docker hub"){
      steps {
        sh 'docker push satluri2/student-survey-app:latest'
      }
    }
       stage("deploying on k8")
    {
           steps{

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
