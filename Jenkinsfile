pipeline {
    agent none
	environment{
		HOME = "C:/Users/raul.moctezuma"
	}
    stages {
		stage('Copy rdl from repository'){
			agent any
			steps{
				powershell 'copy *.rdl C:/Users/raul.moctezuma/Documents/docker_rdl'
			}
		}
        stage('Remove volumes, containers and images'){
			agent any
            steps{
                powershell'''
                    docker stop prototipo_admincontenido | out-null
                    docker rm rdl_admincontenido | out-null
                    docker rm prototipo_admincontenido | out-null
                    docker rm screenshots_admincontenido | out-null
                    docker rm plantuml_admincontenido | out-null
					
					docker rmi softtek:rdl-admincontenido | out-null
					docker rmi softtek:riot-admincontenido | out-null
					docker rmi softtek:screenshots-admincontenido | out-null
					docker rmi softtek:plantuml-admincontenido | out-null
					
                    docker volume rm v-rdl-admincontenido | out-null
                    docker volume rm v-screenshots-admincontenido | out-null
                    docker volume rm v-uml-admincontenido | out-null
					
                    docker volume create --name v-rdl-admincontenido
                    docker volume create --name v-screenshots-admincontenido
                    docker volume create --name v-uml-admincontenido
				'''
            }
        }
        stage('RDL Generator'){
			agent any
            steps{
                powershell '''
                    cd C:/Users/raul.moctezuma/Documents/docker_rdl
                    docker build . -t "softtek:rdl-admincontenido"
                    docker run --name rdl_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen softtek:rdl-admincontenido
                '''
            }
        }
        stage('Prototype'){
			agent any
            steps{
                powershell '''
                    cd C:/Users/raul.moctezuma/Documents/docker_riot
                    docker build . -t  "softtek:riot-admincontenido"
                    docker run -d --name prototipo_admincontenido -p 1337:1337/tcp -v v-rdl-admincontenido:/rdl/input/src-gen softtek:riot-admincontenido
                '''
            }
        }
        stage('Screenshots'){
			agent any
            steps{
                powershell '''
                    cd C:/Users/raul.moctezuma/Documents/docker_screenshots
                    docker build . -t  "softtek:screenshots-admincontenido"
                    docker run --name screenshots_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen -v v-screenshots-admincontenido:/cypress/screenshots softtek:screenshots-admincontenido
				'''
            }
        }
        stage('UML'){
			agent any
            steps{
                powershell '''
                    cd C:/Users/raul.moctezuma/Documents/docker-plantuml
                    docker build . -t  "softtek:plantuml-admincontenido"
                    docker run --name plantuml_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen -v v-uml-admincontenido:/plantuml softtek:plantuml-admincontenido
                '''
            }
        }
    }
}
