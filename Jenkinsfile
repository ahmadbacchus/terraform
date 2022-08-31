pipeline{
    agent any
    stages{
        stage('terraform'){
            steps{
                sh "whoami"
                sh "pwd"

                dir("vm"){
                    sh "/opt/homebrew/bin/terraform init"
                    sh "/opt/homebrew/bin/terraform fmt"
                    sh "/opt/homebrew/bin/terraform apply -var-file='dev.tfvars' -auto-approve"
                }
                
                
            }
        }
    }
}