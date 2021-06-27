pipeline {
    agent any
    stages {
        stage('dependency') {
            agent {
                docker {
                    image 'circleci/python:3.6.2-stretch-browsers'
                    // args '-e FLASK_CONFIG=testing -e TEST_DATABASE_URL=postgresql://ubuntu@localhost/circle_test?sslmode=disable -v $HOME:/'
                    args "-v ${env.WORKSPACE}:/home/circleci/"
                    reuseNode true
                }
            }
            steps {
                sh 'echo "Creating virtualenv"'
                            sh 'python3 -m venv venv'

                            sh 'echo "virtualenv location"'
                            sh 'pwd'

                            sh 'echo "Activating virtualenv"'
                            sh '. venv/bin/activate'

                            sh 'echo "Installing dependenices"'
                            sh 'pip install -r requirements/dev.txt'
                            
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
