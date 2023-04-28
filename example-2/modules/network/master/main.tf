data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_master" {
  provider   = aws
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Env =  var.profile
  }
}

resource "aws_internet_gateway" "igw_master_frankfurt" {
  provider = aws
  vpc_id   = aws_vpc.vpc_master.id

  tags = {
    Env =  var.profile
  }
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Env =  var.profile
  }
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Env =  var.profile
  }
}

resource "aws_vpc_peering_connection" "master_worker_peering_connection" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.bar.id
  vpc_id        = aws_vpc.foo.id

  tags = {
    Env =  var.profile
  }
}
