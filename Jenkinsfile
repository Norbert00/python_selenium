pipeline {
    agent {
       label "python_chromedriver"
    }
    environment {
        recipientEmails = "nocnica@protonmail.com"
    } 
    stages {
        stage ("Run") {
            steps {
                sh "python3 ${env.WORKSPACE}/seleniumpy.py"
            }
        }
    }
    post {
        always {
            cleanWs()
            emailext to: "${env.recipientEmails}",
            subject: "jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}"
        }
    }
} 