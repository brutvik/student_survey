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
                    sh 'jar -cvf student_survey.war -C /student_survey .'
                    sh 'echo ${BUILD_TIMESTAMP}'
                    sh "docker login -u rutvikbrk1 -p ${DOCKERHUB_PASS}"
                    sh 'docker build -t rutvikbrk1/student_survey:latest .'

                }
            }
        }
    stage("Pushing Image to DockerHub") {
        steps {
            script {
                sh 'docker push rutvikbrk1/student_survey:latest'
            }
        }
    }
    stage("Deploying to Rancher as single pod") {
        steps{
            sh 'kubectl set image deployment/node-port container-0=rutvikbrk1/student_survey:latest'
        }
    }
    stage("Deploying to Rancher as load balancer"){
        steps {
            sh 'kubectl set image deployment/studentsurvey645-lb studentsurvey645-lb=rutvikbrk1/645:latest -n jenkins-pipeline'
        }
    }
    }
}
