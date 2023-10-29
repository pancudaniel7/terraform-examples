terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "eu-central-1"
    key     = "terraform.tfstate"
    bucket  = "state-66774455"
    encrypt = true
  }
}