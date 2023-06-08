data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_worker" {
  provider   = aws.worker
  cidr_block = "192.168.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Env =  var.env
  }
}

resource "aws_internet_gateway" "igw_worker" {
  provider = aws.worker
  vpc_id   = aws_vpc.vpc_worker.id

  tags = {
    Env =  var.env
  }
}

resource "aws_subnet" "subnet_worker_1" {
  provider   = aws.worker
  vpc_id     = aws_vpc.vpc_worker.id
  cidr_block = "192.168.1.0/24"
}