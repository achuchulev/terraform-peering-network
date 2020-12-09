### VPC module outputs

output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  value = module.vpc_b.vpc_id
}

output "vpc_a_subnet_ids" {
  value = module.vpc_a.subnet_ids
}

output "vpc_b_subnet_ids" {
  value = module.vpc_accepter.subnet_ids
}

output "ec2_vpc_a_public_ip" {
  value = module.ec2_vpc_a.public_ip
}

output "ec2_vpc_b_public_ip" {
  value = module.ec2_vpc_b.public_ip
}

### Peering module outputs

output "peering_connection_id" {
  value = module.vpc_peering.connection_id
}

output "peering_status" {
  value = module.vpc_peering.accept_status
}
