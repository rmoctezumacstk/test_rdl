pipeline {
    agent none
    stages {
        stage('Remove'){
		agent any
            steps{
                bat'''
                    docker stop softtek_prototipo > nul 2>&1
                    docker rm softtek_plantuml > nul 2>&1
                    docker rm softtek_screenshots > nul 2>&1
                    docker rm softtek_prototipo > nul 2>&1
                    docker rm softtek_rdl > nul 2>&1
                    docker volume rm output-rdl > nul 2>&1
                    docker volume rm pdf_rdl > nul 2>&1
                    docker volume rm screenshots-cypress > nul 2>&1
                    docker volume rm uml_images > nul 2>&1
                    docker volume create --name output-rdl
                    docker volume create --name screenshots-cypress
                    docker volume create --name uml_images
                    docker volume create --name pdf_rdl
            '''
            }
        }
        stage('rdl_generator'){
			agent any
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/docker_softtek_java8
                    docker build . -t "softtek:java8"
                    docker run --name softtek_rdl -v output-rdl:/rdl/input/src-gen softtek:java8
                '''
            }
        }
        stage('prototype'){
			agent any
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/nodejs-angular
                    docker build . -t  "softtek:nodejs"
                    docker run -d --name softtek_prototipo -p 1337:1337/tcp -v output-rdl:/rdl/input/src-gen softtek:nodejs
                '''
            }
        }
        stage('screenshots'){
			agent any
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/docker-cypress-screenshots
                    docker build . -t  "softtek:cypress"
                    docker run --name softtek_screenshots -v output-rdl:/rdl/input/src-gen -v screenshots-cypress:/cypress/screenshots softtek:cypress
            '''
            }
        }
        stage('plantuml'){
			agent any
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/docker-plantuml
                    docker build . -t  "softtek:plantuml"
                    docker run --name softtek_plantuml -v output-rdl:/rdl/input/src-gen -v uml_images:/plantuml softtek:plantuml
                '''
            }
        }
    }
}
