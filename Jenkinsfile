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
                sh 'python3 -m venv venv'

                sh 'echo "Activating virtualenv"'
                sh '. venv/bin/activate'

                sh 'echo "Updating pip, wheel and setuptools"'
                sh 'python -m pip install --upgrade pip setuptools wheel'

                sh 'echo "Installing dependenices"'
                sh 'pip install -r requirements/dev.txt'
            }
        }
        stage('Test') {
            environment {
                FLASK_CONFIG = 'testing'
                TEST_DATABASE_URL = 'postgresql://ubuntu@localhost/circle_test?sslmode=disable'
            }
            node {
                docker.image('circleci/postgres:9.6.5-alpine-ram').withRun('-e POSTGRES_USER=ubuntu -e POSTGRES_DB=circle_test -e POSTGRES_PASSWORD="" -p 5432:5432') { c ->
                    docker.image('circleci/postgres:9.6.5-alpine-ram').inside("--link ${c.id}:db") {
                        /* Wait until mysql service is up */
                        sh 'while ! pg_isready -U ubuntu -h db -q; do sleep 1; done'
                    }
                    docker.image('circleci/python:3.6.2-stretch-browsers').inside("--link ${c.id}:db -e FLASK_CONFIG=testing -e TEST_DATABASE_URL=postgresql://ubuntu@localhost/circle_test?sslmode=disable -v $HOME/:/root/") {
                        /*
                        * Run some tests which require MySQL, and assume that it is
                        * available on the host name `db`
                        */
                        sh 'echo Testing..'
                        sh 'python manage.py test'
                    }
                }
            }
            steps {
                sh 'echo Testing..'
                sh 'python manage.py test'

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
