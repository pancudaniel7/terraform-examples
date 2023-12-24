resource "aws_vpc_peering_connection_accepter" "vpc_master_peering_accepter" {
  provider = aws.worker

  vpc_peering_connection_id = var.vpc_peering_connection1_id
  auto_accept               = true

  tags = {
    Environment = var.env
  }
}