variable "env" {
  type    = string
  default = "default"
}

variable "vpc_master_id" {
  description = "Master vpc id"
  type        = string
}

variable "vpc_worker_id" {
  description = "Worker vpc id"
  type        = string
}