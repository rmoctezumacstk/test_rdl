pipeline {
    agent none
    stages {
        stage('Test'){
			agent any
			steps{
				bat 'docker volume create --name output-rdl'
			}
        }
	}
}
