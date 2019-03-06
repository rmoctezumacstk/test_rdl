pipeline {
    agent none
	
    stages {
		
		def rdlName
		
		stage('copy_rdl'){
			agent any
			steps{
				rdlName = powershell(returnStdout: true, script: 'get-childitem "*.rdl" | Select-Object -ExpandProperty Name').trim()
				powershell 'echo ${rdlName}'
			}			
		}
    }
}
