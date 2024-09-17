variable "regions" {
  type    = list(string)
  default = ["eu-south-1", "eu-north-1"]
}

variable "vpc_count_per_region" {
  type  = number
  default = 3
}

variable "vm_count_per_vpc" {
  type = number
  default = 50
}

