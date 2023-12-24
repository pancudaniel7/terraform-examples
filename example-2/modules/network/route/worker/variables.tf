variable "env" {
  type    = string
  default = "default"
}

variable "vpc_worker_id" {
  description = "Worker vpc id"
  type        = string
}

variable "igw_worker_ireland_id" {
  description = "Worker igw ireland"
  type        = string
}

variable "master_peering_connection_id" {
  description = "Peering connection id"
  type        = string
}