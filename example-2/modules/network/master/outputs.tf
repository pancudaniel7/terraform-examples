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

output "standard1_master_id" {
  value = aws_security_group.standard1_master.id
  description = "Standard1 security group id"
}