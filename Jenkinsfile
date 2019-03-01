pipeline {
    agent none
    stages {
        stage('Test'){
			agent any
			steps{
				bat 'docker rm softtek_plantuml'
			}
        }
	}
}
