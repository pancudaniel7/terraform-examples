variable "env" {
  type    = string
  default = "default"
}

variable "vpc_master_id" {
  description = "Master vpc id"
  type        = string
}

variable "igw_master_frankfurt_id" {
  description = "Master igw frankfurt"
  type        = string
}

variable "peering_connection_master_id" {
  description = "Master peering connection id "
  type        = string
}