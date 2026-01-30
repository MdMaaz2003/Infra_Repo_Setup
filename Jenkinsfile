pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        /* =========================
           CI PIPELINE (PR)
        ========================= */

        stage('Terraform Init (CI)') {
            when {
                changeRequest()
            }
            steps {
                bat 'terraform init -backend=false'
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
           CD PIPELINE (MAIN)
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
                    bat 'terraform init'
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
                      -var="ami_id=ami-0abcdef12345" ^
                      -var="key_name=my-key" ^
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
                    bat 'terraform apply tfplan'
                }
            }
        }
    }
}

