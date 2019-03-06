pipeline {
    agent none
	
	def rdlName = powershell(returnStdout: true, script: 'get-childitem "*.rdl" | Select-Object -ExpandProperty Name').trim()
	
    stages {
		stage('copy_rdl'){
			agent any
			steps{
				powershell 'echo ${rdlName}'
			}			
		}
    }
}
