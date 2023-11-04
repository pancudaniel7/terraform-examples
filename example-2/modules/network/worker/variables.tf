variable "env" {
  type    = string
  default = "default"
}

variable "security_group_standard1_vpc_id" {
  description = "VPC id for the security group to be registered"
  type        = string
}

variable "security_group_standard1_name" {
  description = "Security group name"
  type        = string
}