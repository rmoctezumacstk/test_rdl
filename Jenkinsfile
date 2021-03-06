pipeline {
	agent none
	stages {
		stage('Copy rdl from repository'){
			agent any
			steps{
				powershell 'copy *.rdl ./docker_rdl'
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
					docker rm latex_admincontenido | out-null
					
					docker rmi softtek:rdl-admincontenido | out-null
					docker rmi softtek:riot-admincontenido | out-null
					docker rmi softtek:screenshots-admincontenido | out-null
					docker rmi softtek:plantuml-admincontenido | out-null
					docker rmi softtek:latex-admincontenido | out-null
					docker rmi softtek:pdf-admincontenido | out-null
					
					docker volume rm v-rdl-admincontenido | out-null
					docker volume rm v-screenshots-admincontenido | out-null
					docker volume rm v-uml-admincontenido | out-null
					docker volume rm v-pdf-admincontenido | out-null
					
					docker volume create --name v-rdl-admincontenido
					docker volume create --name v-screenshots-admincontenido
					docker volume create --name v-uml-admincontenido
					docker volume create --name v-pdf-admincontenido
				'''
			}
		}
		stage('RDL Generator'){
			agent any
			steps{
				powershell '''
					cd ./docker_rdl
					docker build . -t "softtek:rdl-admincontenido"
					docker run --name rdl_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen softtek:rdl-admincontenido
				'''
			}
		}
		stage('Prototype'){
			agent any
			steps{
				powershell '''
					cd ./docker_riot
					Get-ChildItem ./copy.sh | ForEach-Object {
					$contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
					$utf8 = New-Object System.Text.UTF8Encoding $false
					[IO.File]::WriteAllText($_, $contents, $utf8)
					}
					docker build . -t  "softtek:riot-admincontenido"
					docker run -d --name prototipo_admincontenido -p 1337:1337/tcp -v v-rdl-admincontenido:/rdl/input/src-gen softtek:riot-admincontenido
				'''
			}
		}
		stage('Screenshots'){
			agent any
			steps{
				powershell '''
					cd ./docker_screenshots
					Get-ChildItem ./copy.sh | ForEach-Object {
					$contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
					$utf8 = New-Object System.Text.UTF8Encoding $false
					[IO.File]::WriteAllText($_, $contents, $utf8)
					}
					docker build . -t  "softtek:screenshots-admincontenido"
					docker run --name screenshots_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen -v v-screenshots-admincontenido:/cypress/screenshots softtek:screenshots-admincontenido
				'''
			}
		}
		stage('UML images'){
			agent any
			steps{
				powershell '''
					cd ./docker-plantuml
					Get-ChildItem ./copy.sh | ForEach-Object {
					$contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
					$utf8 = New-Object System.Text.UTF8Encoding $false
					[IO.File]::WriteAllText($_, $contents, $utf8)
					}
					docker build . -t  "softtek:plantuml-admincontenido"
					docker run --name plantuml_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen -v v-uml-admincontenido:/plantuml softtek:plantuml-admincontenido
				'''
			}
		}
		stage('Create PDF with Latex'){
			agent any
			steps{
				powershell '''
					cd ./docker_latex
					Get-ChildItem ./copy.sh | ForEach-Object {
					$contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
					$utf8 = New-Object System.Text.UTF8Encoding $false
					[IO.File]::WriteAllText($_, $contents, $utf8)
					}
					docker build . -t  "softtek:latex-admincontenido"
					docker run --name latex_admincontenido -v v-rdl-admincontenido:/rdl/input/src-gen -v v-screenshots-admincontenido:/cypress/screenshots -v v-uml-admincontenido:/plantuml -v v-pdf-admincontenido:/pdf softtek:latex-admincontenido
				'''
			}
		}
		stage('Publish PDF'){
			agent any
			steps{
				powershell '''
					cd ./docker_pdf
					docker cp latex_admincontenido:/pdf/functional-spec.pdf ./
					docker build . -t softtek:pdf-admincontenido
					docker run --name pdf_admincontenido -d -p 4200:80 softtek:pdf-admincontenido
				'''
			}
		}
	}
}
