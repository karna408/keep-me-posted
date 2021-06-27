pipeline {
    agent any
    stages {
        stage('dependency') {
        
            agent {
                docker {
                    image 'ubuntu:latest'
                    // args '-e FLASK_CONFIG=testing -e TEST_DATABASE_URL=postgresql://ubuntu@localhost/circle_test?sslmode=disable -v $HOME:/'
                    args "-v ${env.WORKSPACE}:/home/circleci/"
                    reuseNode true
                }
            }
            
            steps {
                sh 'echo "Test Dir"'
                sh 'mkdir test-reports'
                
                sh 'sudo apt update && sudo apt install software-properties-common && sudo add-apt-repository ppa:deadsnakes/ppa && sudo apt update && sudo apt install python3.8'

                sh 'echo "Creating virtualenv"'
                sh 'python3 -m venv venv'

                sh 'echo "virtualenv location"'
                sh 'ls'
                sh 'echo "Activating virtualenv"'

                sh 'cd venv'
                sh '. bin/activate'

                sh 'which pip'

                sh 'echo $PATH'

                sh 'echo "Installing dependenices"'                      
                sh 'pip install -r requirements/common.txt'
            }
        }
        stage('build and test') {
            steps {
                script {
                    echo 'Testing....'
                    docker.image('circleci/postgres:9.6.5-alpine-ram').withRun('-e POSTGRES_USER=ubuntu -e POSTGRES_DB=circle_test -e POSTGRES_PASSWORD="" -p 5432:5432') { c ->
                        /*docker.image('circleci/postgres:9.6.5-alpine-ram').inside("--link ${c.id}:db") {
                            sh 'echo postgres db'
                        }*/
                        docker.image('circleci/python:3.6.2-stretch-browsers').inside('-v ${WORKSPACE}:/home/circleci -e FLASK_CONFIG=testing -e TEST_DATABASE_URL=postgresql://ubuntu@localhost/circle_test?sslmode=disable') {
                            sh 'python manage.py test'
                        }
                    }
                }
            }
        }
    }
}
