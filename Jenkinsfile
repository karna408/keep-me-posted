pipeline {
    agent any
    stages {
        stage('dependency') {
            steps {
                sh 'echo "Test Dir"'
                //sh 'mkdir test-reports'             
                sh 'sudo apt update && sudo apt install software-properties-common && sudo add-apt-repository ppa:deadsnakes/ppa && sudo apt update && sudo apt install -y python3.8'
                sh 'sudo apt install -y python3-pip libpq-dev postgresql-client-common postgresql-client-10'
                sh 'echo "Installing dependenices"'                      
                sh 'pip3 install -r requirements/dev.txt'
            }
        }
        stage('build and test') {
            environment {
                FLASK_CONFIG='testing'
                TEST_DATABASE_URL='postgresql://ubuntu@localhost/circle_test?sslmode=disable'
            }
            steps {
                script {
                    echo 'Testing....'
                    docker.image('circleci/postgres:9.6.5-alpine-ram').withRun('-e POSTGRES_USER=ubuntu -e POSTGRES_DB=circle_test -e POSTGRES_PASSWORD="" -p 5432:5432') { c ->
                        sh 'while ! pg_isready -U ubuntu -h localhost -p 5432 -d circle_test -q; do sleep 1; done'
                        sh 'python3 manage.py test'
                    }
                }
            }
        }
        stage('dockerizing') {
            steps{
                sh 'sudo docker build -t t-app .'
            }
        }
        stage('cleanup'){
            steps {
                cleanWs()
            
            }
        
        }
    }
}
