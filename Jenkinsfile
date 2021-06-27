pipeline {
    agent any
    stages {
        stage('Upgrading pip, wheel and setuptools') {
            agent {
                docker {
                    image 'circleci/python:3.6.2-stretch-browsers'
                    args '-u circleci:circleci'
                }
            }
            steps {
                sh 'echo "where an i"'
                sh 'cat /etc/passwd'

                sh 'echo "Creating virtualenv"'
                sh 'python3 -m venv venv'

                sh 'echo "Activating virtualenv"'
                sh '. venv/bin/activate'

                sh 'echo "virtualenv location"'
                sh 'pwd'

                sh 'echo "Installing dependenices"'
                sh 'sudo -H pip install -r requirements/dev.txt'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
