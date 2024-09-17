# Outputs
output "vpc_ids" {
  description = "IDs of the VPCs created"
  value = aws_vpc.vpc[*].id
}

output "subnet_ids" {
  description = "IDs of the subnets created"
  value = aws_subnet.subnet[*].id
}

output "vm_ids" {
  description = "IDs of the VMs created"
  value = aws_instance.vm[*].id
}

output "eks_cluster_ids" {
  description = "IDs of the EKS clusters created"
  value = aws_eks_cluster.eks[*].id
}

output "eks_role_arn" {
  description = "ARN of the IAM role created for EKS"
  value = aws_iam_role.eks_role.arn
}
