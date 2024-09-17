# Provider configuration for each region
terraform {
  required_version = "= 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }
}

provider "aws" {
  alias  = "region"
  region = var.region
}


# Create VPCs
resource "aws_vpc" "vpc" {
  count = var.vpc_count
  cidr_block = "10.${count.index}.0.0/16"
  tags = {
    Name = "vpc-${count.index}"
  }
  provider = aws.region
}

# Get availability zones
data "aws_availability_zones" "available" {
  provider = aws.region
}

# Create subnets
resource "aws_subnet" "subnet" {
  count = var.vpc_count * var.subnet_count_per_vpc  # Create 3 subnets per VPC

  vpc_id            = element(aws_vpc.vpc[*].id, floor(count.index / 3))
  cidr_block        = cidrsubnet(element(aws_vpc.vpc[*].cidr_block, floor(count.index / 3)), 8, count.index % 3)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name = "subnet-${floor(count.index / 3)}-${count.index % 3}"
  }

  provider = aws.region
}

# Create VMs in each VPC
resource "aws_instance" "vm" {
  count = var.vpc_count * var.vm_count

  ami           = var.ami # Example AMI ID
  instance_type = "t3.micro"
  subnet_id     = element(aws_subnet.subnet[*].id, floor(count.index / var.vm_count) * 3 + (count.index % 3))

  tags = {
    Name = "vm-${floor(count.index / var.vm_count)}-${count.index % var.vm_count}"
  }

  provider = aws.region
}

# Create IAM role for EKS
resource "aws_iam_role" "eks_role" {
  name = "asrirang_eks_role_1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  provider = aws.region
}

# Attach policies to the IAM role for EKS
resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  provider = aws.region
}

# Create EKS clusters in each VPC
resource "aws_eks_cluster" "eks" {
  count = var.vpc_count

  name     = "eks-${count.index}"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [for i in range(3) : element(aws_subnet.subnet[*].id, count.index * 3 + i)]
  }

  provider = aws.region
}



