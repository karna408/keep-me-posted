pipeline {
    agent {
        docker {
            image 'circleci/python:3.6.2-stretch-browsers'
            args '-e FLASK_CONFIG=testing -e TEST_DATABASE_URL=postgresql://ubuntu@localhost/circle_test?sslmode=disable'
            reuseNode true
        }
    }
    stages {
        stage('Testing') {
            steps {
                script {
                    echo 'Testing....'
                    docker.image('circleci/postgres:9.6.5-alpine-ram').withRun('-e POSTGRES_USER=ubuntu -e POSTGRES_DB=circle_test -e POSTGRES_PASSWORD="" -p 5432:5432') { c ->
                        sh 'python manage.py test'
                    }
                }
            }
        }
        stage('Upgrading pip, wheel and setuptools') {
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
        
    }
}
