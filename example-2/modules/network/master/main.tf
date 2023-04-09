data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_master" {
  provider   = aws
  cidr_block = "10.0.0.0/16"
  
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "master"
  }
}

resource "aws_internet_gateway" "igw_master_frankfurt" {
  provider = aws
  vpc_id   = aws_vpc.vpc_master.id

  tags = {
    Name = "master"
  }
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
}
