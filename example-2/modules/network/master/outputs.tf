output "vpc_id" {
  value = aws_vpc.vpc_master.id
  description = "Master VPC id"
}

output "subnet_master1_id" {
  value = aws_subnet.subnet_master_1.id
  description = "Subnet master1 id"
}

output "subnet_master2_id" {
  value = aws_subnet.subnet_master_2.id
  description = "Subnet master2 id"
}