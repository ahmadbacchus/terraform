pipeline{
    agent any
    parameters{
      choice(choices: ['create', 'destroy'],name: 'action')
    }
    environments{
        terraform = "/opt/homebrew/bin/terraform"
    }
    stages{
        stage('terraform'){
            steps{
                dir("vm"){
                    sh "${env.terraform} init"
                    sh "${env.terraform} fmt"
                    script{
                        if (params.action == "create") {
                            sh "${env.terraform} apply -var-file='dev.tfvars' -auto-approve"
                        }else if (params.action == "destroy") {
                            sh "${env.terraform} destroy -var-file='dev.tfvars' -auto-approve"
                        }
                    }
                }
            }
        }
    }
}