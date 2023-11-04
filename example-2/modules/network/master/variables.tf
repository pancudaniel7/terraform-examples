variable "env" {
  type    = string
  default = "default"
}
variable "worker_region" {
  type        = string
  description = "The region where worker resources will be created"
}

variable "vpc_worker_id" {
  type        = string
  description = "The worker VPC id to be used for peer connection"
}

variable "igw_worker_id" {
  type    = string
  description = "The worker internet gateway id"
}

variable "subnet_1_worker_id" {
  type    = string
  description = "The worker subnet 1 id"
}

variable "security_group_standard1_vpc_id" {
  description = "VPC id for the security group to be registered"
  type        = string
}

variable "security_group_standard1_name" {
  description = "Security group name"
  type        = string
}
