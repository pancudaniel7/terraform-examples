data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_master" {
  provider   = aws.master
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = var.env
  }
}

resource "aws_internet_gateway" "igw_master_frankfurt" {
  provider = aws.master
  vpc_id   = aws_vpc.vpc_master.id

  tags = {
    Environment = var.env
  }
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws.master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Environment = var.env
  }
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws.master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Environment = var.env
  }
}

# VPC peering
resource "aws_vpc_peering_connection" "master_peering_connection" {
  provider = aws.master
  vpc_id      = aws_vpc.vpc_master.id
  
  peer_vpc_id = var.vpc_worker_id
  peer_region = var.worker_region

  tags = {
    Environment = var.env
  }
}

resource "aws_vpc_peering_connection_accepter" "vpc_master_peering_accepter" {
  provider = aws.worker

  vpc_peering_connection_id = aws_vpc_peering_connection.master_peering_connection.id
  auto_accept               = true

  tags = {
    Environment = var.env
  }
}

resource "aws_route_table" "master_routing_table" {
  provider = aws.master
  vpc_id   = aws_vpc.vpc_master.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_master_frankfurt.id
  }

  route {
    cidr_block = "192.168.1.0/24"
    gateway_id = aws_vpc_peering_connection.master_peering_connection.id
  }
  
  lifecycle {
    ignore_changes = all
  }

  tags = {
    Environment = var.env
  }
}

resource "aws_main_route_table_association" "master_routing_table_association" {
  provider = aws.master
  vpc_id = aws_vpc.vpc_master.id
  route_table_id = aws_route_table.master_routing_table.id
}


resource "aws_route_table" "worker_routing_table" {
  provider   = aws.worker
  vpc_id     = var.vpc_worker_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_worker_id
  }
  
  route {
    cidr_block = "10.0.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.master_peering_connection.id
  }
  
  lifecycle {
    ignore_changes = all
  }

  tags = {
    Environment = var.env
  }
}

resource "aws_main_route_table_association" "worker_routing_table_association" {
  provider = aws.worker
  vpc_id = var.vpc_worker_id
  route_table_id = aws_route_table.worker_routing_table.id
}


