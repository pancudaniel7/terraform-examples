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

resource "aws_vpc" "example1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "example1" {
  vpc_id = aws_vpc.example1.id
}

resource "aws_route_table" "example1" {
  vpc_id = aws_vpc.example1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example1.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.example1.id
  }
}

resource "aws_subnet" "example1" {
  vpc_id            = aws_vpc.example1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.example1.id
  route_table_id = aws_route_table.example1.id
}

resource "aws_security_group" "example1_allow_tls" {
  name        = "example1_allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.example1.id

  ingress {
    description      = "HTTP"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.example1.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.example1.ipv6_cidr_block]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.example1.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.example1.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_network_interface" "example1" {
  subnet_id       = aws_subnet.public_a.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.example1.id]
}

resource "aws_eip" "example1" {
  vpc                       = true
  network_interface         = aws_network_interface.example1.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.example1
  ]
}

resource "aws_key_pair" "example1" {
  key_name   = "terra_id_rsa"
  public_key = file("~/.ssh/terra_id_rsa.pub")
}

resource "aws_instance" "example1_ec2" {
  ami               = "ami-0d1ddd83282187d18"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = "example1"

  depends_on = [
    aws_key_pair.example1
  ]

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.example1.id
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install openjdk-11-jdk",
      "sudo apt-get install -y nginx"
    ]
  }

  tags = {
    Name = "instance1"
  }
}
