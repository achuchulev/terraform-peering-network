### VPC module outputs

output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  value = module.vpc_b.vpc_id
}

# ec2 module outputs
output "ec2_vpc_a_public_ip" {
  value = module.ec2_vpc_a.public_ip
}

output "ec2_vpc_b_public_ip" {
  value = module.ec2_vpc_b.public_ip
}

output "ec2_vpc_a_private_ip" {
  value = module.ec2_vpc_a.private_ip
}

output "ec2_vpc_b_private_ip" {
  value = module.ec2_vpc_b.private_ip
}

### Peering module outputs

output "peering_connection_id" {
  value = module.vpc_peering.connection_id
}

output "peering_status" {
  value = module.vpc_peering.accept_status
}
