resource "aws_route_table" "worker_routing_table" {
  provider   = aws.worker
  vpc_id     = var.vpc_worker_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_worker_ireland_id
  }

  route {
    cidr_block = "10.0.1.0/24"
    vpc_peering_connection_id = var.master_peering_connection_id
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