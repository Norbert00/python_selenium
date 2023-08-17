pipeline {
    agent {
       label "python_chromedriver"
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
        }
    }
} 