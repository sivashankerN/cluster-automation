
pipeline {
    agent any
    stages {
        stage('Build'){
            steps {
                sh 'make' 
            }
        }
        stage('Test') {
            steps { 
                sh 'ls' 
            }
        }
        stage('Deploy') {
            steps { 
                sh 'echo  $HOME'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                    cd $HOME
                    pwd
                    echo "Hello Siva"
                '''
            }
        }
    }
}
