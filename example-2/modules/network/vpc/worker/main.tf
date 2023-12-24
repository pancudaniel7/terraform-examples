data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_worker" {
  provider   = aws
  cidr_block = "192.168.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Env =  var.env
  }
}

resource "aws_internet_gateway" "igw_worker" {
  provider = aws
  vpc_id   = aws_vpc.vpc_worker.id

  tags = {
    Env =  var.env
  }
}

resource "aws_subnet" "subnet_worker_1" {
  provider   = aws
  vpc_id     = aws_vpc.vpc_worker.id
  cidr_block = "192.168.1.0/24"
}

resource "aws_security_group" "standard1_worker" {
  provider = aws
  name        = "Standard1"
  description = "Standard1 security group"
  vpc_id      = var.security_group_standard1_vpc_id

  // SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Default egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_standard1_name
  }
}

#resource "aws_route_table" "worker_routing_table" {
#  provider   = aws.worker
#  vpc_id     = var.vpc_worker_id
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = var.igw_worker_id
#  }
#
#  route {
#    cidr_block = "10.0.1.0/24"
#    vpc_peering_connection_id = aws_vpc_peering_connection.master_peering_connection.id
#  }
#
#  lifecycle {
#    ignore_changes = all
#  }
#
#  tags = {
#    Environment = var.env
#  }
#}

#resource "aws_main_route_table_association" "worker_routing_table_association" {
#  provider = aws.worker
#  vpc_id = var.vpc_worker_id
#  route_table_id = aws_route_table.worker_routing_table.id
#}