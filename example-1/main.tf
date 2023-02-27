terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.56.0"
    }
  }
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  region     = "eu-central-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_key_pair" "deployer" {
  key_name   = "terra_id_rsa"
  public_key = file("~/.ssh/terra_id_rsa.pub")
}

resource "aws_instance" "example_1_ec2" {
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.micro"
#   key_name = "terra_id_rsa"
}
