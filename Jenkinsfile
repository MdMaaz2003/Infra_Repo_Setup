pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                cleanWs()   // 🔥 VERY IMPORTANT
                checkout scm
            }
        }

        /* =========================
           CI PIPELINE (PULL REQUEST)
           - No backend
           - No state
        ========================= */

        stage('Terraform Init (CI)') {
            when {
                changeRequest()
            }
            steps {
                bat 'terraform init -backend=false -input=false'
            }
        }

        stage('Terraform Format Check (CI)') {
            when {
                changeRequest()
            }
            steps {
                bat 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Validate (CI)') {
            when {
                changeRequest()
            }
            steps {
                bat 'terraform validate'
            }
        }

        /* =========================
           CD PIPELINE (MAIN BRANCH)
           - Uses S3 backend
           - Non-interactive
        ========================= */

        stage('Terraform Init (CD)') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat 'terraform init -reconfigure -input=false'
                }
            }
        }

        stage('Terraform Plan (CD)') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat '''
                    terraform plan ^
                      -var="instance_count=2" ^
                      -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply (CD)') {
            when {
                branch 'main'
            }
            steps {
                input message: "Deploy infrastructure to AWS?"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat 'terraform apply -input=false tfplan'
                }
            }
        }
    }
}
