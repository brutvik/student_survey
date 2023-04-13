pipeline{
    agent any
    environment {
        DOCKERHUB_PASS = 'aparna@pes2017'
    }
    stages {
        stage("Building the Student Survey Image") {
            steps {
                script {
                    checkout scm
                    //sh 'rm -rf *.war'
                    //sh 'jar -cvf StudentSurvey.war -C WebContent/ .'
                    sh 'echo ${BUILD_TIMESTAMP}'
                    sh "docker login -u rutvikbrk1 -p ${DOCKERHUB_PASS}"
                    def customImage = docker.build("rutvikbrk1/645:${BUILD_TIMESTAMP}")
                    sh 'echo ${customImage}'

                }
            }
        }
    stage("Pushing Image to DockerHub") {
        steps {
            script {
                sh 'docker push rutvikbrk1/645:${BUILD_TIMESTAMP}'
            }
        }
    }
    stage("Deploying to Rancher as single pod") {
        steps{
            sh 'kubectl set image deployment/stusurvey-pipeline stusurvey-pipeline=rutvikbrk1/645:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
    }
    stage("Deploying to Rancher as load balancer"){
        steps {
            sh 'kubectl set image deployment/studentsurvey645-lb studentsurvey645-lb=rutvikbrk1/645:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
    }
    }
}
