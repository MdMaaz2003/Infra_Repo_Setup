terraform {
  backend "s3" {
    bucket  = "terrraaabuckkeettt777"
    key     = "infra/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}



