pipeline {
    agent any
    tools {
        maven "Maven3"
        jdk "oraclejdk"
    }
    environment {
        registryCredential = 'ecr:us-east-1:awscred'
        appRegistry = "342479567689.dkr.ecr.us-east-1.amazonaws.com/devopsimg"
        devopsprofileRegistry = "https://342479567689.dkr.ecr.us-east-1.amazonaws.com"
    }

    stages {
        stage('Fetch code') {
            steps {
                git branch: 'master', url: 'https://github.com/Manu1939/final_project.git'
            }
        }


        stage('TEST') {
            steps {
                sh 'mvn test'
            }
        }

        stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('build && SonarQube analysis') {
            environment {
                scannerHome = tool 'sonar'
            }
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=final_project \
                        -Dsonar.projectName=final_project \
                        -Dsonar.projectVersion=0.0.1-SNAPSHOT \
                        -Dsonar.sources=src/ \
                        -Dsonar.java.binaries=target/test-classes/org/devops/maven \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
            
        }
       

       stage('Build App Image') {
       steps {
       
         script {
                dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./")
             }

     }
    
    }

    stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( devopsprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
     } 
    }
}
 
