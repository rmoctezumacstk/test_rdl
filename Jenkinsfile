pipeline {
    agent any
    stages {
        stage('Remove'){
            steps{
                bat'''
                    docker stop softtek_prototipo > nul 2>&1
                    docker rm softtek_plantuml
                    docker rm softtek_screenshots
                    docker rm softtek_prototipo
                    docker rm softtek_rdl
                    docker rmi softtek:plantuml
                    docker rmi softtek:cypress
                    docker rmi softtek:nodejs
                    docker rmi softtek:java8
                    docker volume rm output-rdl
                    docker volume rm pdf_rdl
                    docker volume rm screenshots-cypress
                    docker volume rm uml_images
                    docker volume create --name output-rdl
                    docker volume create --name screenshots-cypress
                    docker volume create --name uml_images
                    docker volume create --name pdf_rdl
            '''
            }
        }
        stage('rdl_generator'){
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/docker_softtek_java8
                    docker build . -t "softtek:java8"
                    docker run --name softtek_rdl -v output-rdl:/rdl/input/src-gen softtek:java8
                '''
            }
        }
        stage('prototype'){
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/nodejs-angular
                    docker build . -t  "softtek:nodejs"
                    docker run -d --name softtek_prototipo -p 1337:1337/tcp -v output-rdl:/rdl/input/src-gen softtek:nodejs
                '''
            }
        }
        stage('screenshots'){
            steps{
                bat '''
                    cd C:/Users/raul.moctezuma/Documents/docker-cypress-screenshots
                    docker build . -t  "softtek:cypress"
                    docker run --name softtek_screenshots -v output-rdl:/rdl/input/src-gen -v screenshots-cypress:/cypress/screenshots softtek:cypress
            '''
            }
        }
        stage('plantuml'){
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
