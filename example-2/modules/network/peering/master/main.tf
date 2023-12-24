resource "aws_vpc_peering_connection" "master_peering_connection" {
  provider = aws
  vpc_id      = var.vpc_master_id

  peer_vpc_id = var.vpc_worker_id
  peer_region = var.vpc_worker_id

  tags = {
    Environment = var.env
  }
}