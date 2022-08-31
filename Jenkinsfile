pipeline{
    agent any
    parameters{
      choice(choices: ['create', 'destroy'],name: 'action')
    }
    stages{
        stage('terraform'){
            steps{
                dir("vm"){
                    sh "/opt/homebrew/bin/terraform init"
                    sh "/opt/homebrew/bin/terraform fmt"
                    if (params.action == "create") {
                        sh "/opt/homebrew/bin/terraform apply -var-file='dev.tfvars' -auto-approve"
                    }else if (params.action == "destroy") {
                        sh "/opt/homebrew/bin/terraform destroy -var-file='dev.tfvars' -auto-approve"
                    }
                }
            }
        }
    }
}