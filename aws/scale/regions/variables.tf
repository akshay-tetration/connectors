variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_count" {
  type  = number
  default = 3
}

variable "subnet_count_per_vpc" {
  type  = number
  default = 3
}

variable "vm_count" {
  type = number
  default = 50
}

variable "ami" {
  type        = string
  description = "The AMI to use for the VMs"
  default     = "ami-08abf76f1e23f10c2"
}