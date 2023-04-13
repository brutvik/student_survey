pipeline{
    agent any
    environment {
        DOCKERHUB_PASS = credentials('docker')
    }
    stages {
        stage("Building the Student Survey Image") {
            steps {
                script {
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf student_survey.war -C /645 .'
                    sh 'echo ${BUILD_TIMESTAMP}'
                    sh "docker login -u rutvikbrk1 -p ${DOCKERHUB_PASS}"
                    sh 'docker build -t rutvikbrk1/student_survey:${BUILD_TIMESTAMP} .'

                }
            }
        }
    stage("Pushing Image to DockerHub") {
        steps {
            script {
                sh 'docker push rutvikbrk1/student_survey:${BUILD_TIMESTAMP}'
            }
        }
    }
    stage("Deploying to Rancher as single pod") {
        steps{
            sh 'kubectl set image deployment/node-port container-0=rutvikbrk1/student_survey:${BUILD_TIMESTAMP}'
        }
    }
    stage("Deploying to Rancher as load balancer"){
        steps {
            sh 'kubectl set image deployment/load-balancer container-0=rutvikbrk1/645:${BUILD_TIMESTAMP}'
        }
    }
    }
}
