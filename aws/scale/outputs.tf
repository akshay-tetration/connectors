# Outputs
output "region0_vpc_ids" {
  description = "IDs of the VPCs created in region 0"
  value = module.regions0.vpc_ids
}

output "region1_vpc_ids" {
  description = "IDs of the VPCs created in region 1"
  value = module.regions1.vpc_ids
}
