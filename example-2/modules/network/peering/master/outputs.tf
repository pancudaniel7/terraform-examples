output "vpc_peering_connection1_id" {
  value = aws_vpc_peering_connection.master_peering_connection.id
  description = "Peering connection1 ID"
}