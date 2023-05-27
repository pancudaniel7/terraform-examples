output "vpc_id" {
  value = aws_vpc.vpc_worker.id
  description = "Worker VPC id"
}

output "igw_id" {
  value = aws_internet_gateway.igw_worker.id
  description = "Worker internet gateway id"
}

output "subnet_1_id" {
  value = aws_subnet.subnet_worker_1.id
  description = "Worker subnet 1 id"
}