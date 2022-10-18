pipeline { 
agent{label'JDK-ALL-MAVEN'}
triggers { pollSCM('* * * * 1-5') }
stages {
	stage('git cloneing') {
		steps {
		git url: 'https://github.com/shopizer-ecommerce/shopizer' , branch: 'Devloper'
		 
		}
	    }
	    stage ('Publish Build Info') {
            steps {
                sh 'mvn compile'
                
        }
		}
 }
  }