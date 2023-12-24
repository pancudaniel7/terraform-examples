resource "aws_route_table" "master_routing_table" {
  provider = aws
  vpc_id   = var.vpc_master_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_master_frankfurt_id
  }

  route {
    cidr_block = "192.168.1.0/24"
    gateway_id = var.peering_connection_master_id
  }

  lifecycle {
    ignore_changes = all
  }

  tags = {
    Environment = var.env
  }
}

resource "aws_main_route_table_association" "master_routing_table_association" {
  provider = aws
  vpc_id = var.vpc_master_id
  route_table_id = aws_route_table.master_routing_table.id
}