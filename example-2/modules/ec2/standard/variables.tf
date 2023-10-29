variable "env" {
  type    = string
  default = "default"
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the instances"
  default     = "t2.micro"
  type        = string
}

variable "key_name" {
  description = "SSH key name for the instances"
  type        = string
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  type        = string
  default     = ""
}

variable "instance_name" {
  type        = string
  default     = ""
}