pipeline {
    agent any
    stages {
        stage('Upgrading pip, wheel and setuptools') {
            agent {
                docker {
                    image 'circleci/python:3.6.2-stretch-browsers'
                    args '-v $HOME/:/root/'
                    reuseNode true
                }
            }
            steps {
                sh 'echo "Creating virtualenv"'
                sh 'sudo python3 -m venv venv'

                sh 'echo "Activating virtualenv"'
                sh 'sudo . venv/bin/activate'

                sh 'echo "Updating pip, wheel and setuptools"'
                sh 'sudo python -m pip install --upgrade pip setuptools wheel'

                sh 'echo "Installing dependenices"'
                sh 'sudo pip install -r requirements/dev.txt'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
