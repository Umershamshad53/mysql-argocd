pipeline {
  agent any

  environment {
    DOCKER_CREDENTIALS = credentials('docker-hub-login')
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        script {
          env.port = 3001
          env.tag = "Dev-"

          if (env.BRANCH_NAME == "master") {
            env.tag = ""
            env.port = 3000
          }

          sh """
            docker build -t umershamshad/mysql-argocd:${tag}latest -t umershamshad/mysql-argocd:${tag}${BUILD_NUMBER} .
            echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin
            docker push umershamshad/mysql-argocd:${tag}latest
            docker push umershamshad/mysql-argocd:${tag}${BUILD_NUMBER}
            sed -i 's|umershamshad/mysql-argocd:.*|umershamshad/mysql-argocd:${tag}${BUILD_NUMBER}|' stateful.yaml
            git add stateful.yaml
            git commit -m "Update image tag to ${tag}${BUILD_NUMBER}"
            git push origin HEAD:${BRANCH_NAME}
          """
        }
      }
    }
  }

     post {
    success {
      echo "✅ Deployment successful!"
    }
    failure {
      echo "❌ Deployment failed!"
    }
  }
}