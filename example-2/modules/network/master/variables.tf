variable "env" {
  type    = string
  default = "default"
}

variable "master_region" {
  type        = string
  description = "The region where master resources will be created"
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
