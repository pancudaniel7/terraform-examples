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
