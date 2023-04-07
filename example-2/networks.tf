data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}

# Master Frankfurt
resource "aws_vpc" "vpc_master_frankfurt" {
  provider   = aws.region-master
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "master"
  }
}

resource "aws_internet_gateway" "igw_master_frankfurt" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master_frankfurt.id

  tags = {
    Name = "master"
  }
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master_frankfurt.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master_frankfurt.id
  cidr_block        = "10.0.2.0/24"
}


# Master UK ----------
resource "aws_vpc" "vpc_master_uk" {
  provider   = aws.region-worker
  cidr_block = "192.168.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "worker"
  }
}

resource "aws_internet_gateway" "igw_master_uk" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_master_uk.id

  tags = {
    Name = "worker"
  }
}

resource "aws_subnet" "subnet_worker_1" {
  provider   = aws.region-worker
  vpc_id     = aws_vpc.vpc_master_uk.id
  cidr_block = "192.168.1.0/24"
}
