pipeline {
    agent none
	
    stages {
		stage('copy_rdl'){
			agent any
			steps{
				def rdlName = powershell(returnStdout: true, script: 'get-childitem "*.rdl" | Select-Object -ExpandProperty Name').trim()
				powershell 'echo ${rdlName}'
			}			
		}
    }
}
