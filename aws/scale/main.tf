terraform {
  required_version = "= 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }
}

module "regions0" {
  source    = "./regions"
  region    = var.regions[0]
  vpc_count = var.vpc_count_per_region
  vm_count  = var.vm_count_per_vpc
  ami       = "ami-0a619440e627643ec"
}

module "regions1" {
  source    = "./regions"
  region    = var.regions[1]
  vpc_count = var.vpc_count_per_region
  vm_count  = var.vm_count_per_vpc
  ami       = "ami-055acd5b1f1672b15"
}
