output "vpc_id" {
  value = aws_vpc.vpc_worker.id
  description = "Worker VPC id"
}
