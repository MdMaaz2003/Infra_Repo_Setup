terraform {
  backend "s3" {
    bucket         = "terrraaabuckkeettt777"   # CHANGE THIS
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

