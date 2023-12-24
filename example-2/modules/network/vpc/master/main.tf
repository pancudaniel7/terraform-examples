data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "vpc_master" {
  provider   = aws
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = var.env
  }
}

resource "aws_internet_gateway" "igw_master_frankfurt" {
  provider = aws
  vpc_id   = aws_vpc.vpc_master.id

  tags = {
    Environment = var.env
  }
}

resource "aws_subnet" "subnet_master_1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Environment = var.env
  }
}

resource "aws_subnet" "subnet_master_2" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Environment = var.env
  }
}

#resource "aws_security_group" "standard1_master" {
#  provider = aws
#  name        = "Standard1"
#  description = "Standard1 security group"
#  vpc_id      = var.security_group_standard1_vpc_id
#
#  // SSH access
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  # Default egress rule to allow all outbound traffic
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name = var.security_group_standard1_name
#  }
#}



