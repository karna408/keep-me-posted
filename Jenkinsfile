pipeline {
    agent any
    stages {
        stage('Upgrading pip, wheel and setuptools') {
            agent {
                docker {
                    image 'python:3.7'
                    args '-v $HOME/:/root/ -u 1000:1000'
                    reuseNode true
                }
            }
            steps {
                sh 'echo "Creating virtualenv"'
                sh 'python3 -m venv venv'

                sh 'echo "Activating virtualenv"'
                sh '. venv/bin/activate'

                sh 'echo "Installing dependenices"'
                sh 'pip install -r requirements/dev.txt'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
