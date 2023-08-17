pipeline {
    agent "python_chromedriver"
    stages {
        stage ("Run") {
            steps {
                sh "python ${env.WORKSPACE}/seleniumpy.py"
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
} 