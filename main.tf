module "vpc_a" {
  source = "./modules/aws_vpc"

  aws_access_key = var.requester_aws_access_key
  aws_secret_key = var.requester_aws_secret_key
  aws_region     = var.requester_region
  aws_token      = var.aws_token

  vpc_cidr_block         = var.requester_vpc_cidr_block
  vpc_subnet_cidr_blocks = var.requester_vpc_subnet_cidr_blocks

  vpc_tags = {
    Name = var.requester_vpc_name
    Side = "Requester"
  }
}

module "security_group_ssh_icmp_vpc_a" {
  source = "./modules/aws_security_group"
  
  aws_vpc_id = module.vpc_a.vpc_id
}

module "ec2_vpc_a" {
  source = "./modules/aws_ec2"
  
  ami = var.ami_a
  subnet_id = module.vpc_a.subnet_ids[0]
  vpc_security_group_ids = [module.security_group_ssh_icmp_vpc_a.id]
  aws_key_pair_name = var.aws_key_pair_name_vpc_a
}

module "vpc_b" {
  source = "./modules/aws_vpc"

  aws_access_key = var.accepter_aws_access_key
  aws_secret_key = var.accepter_aws_secret_key
  aws_region     = var.accepter_region
  aws_token      = var.aws_token

  vpc_cidr_block         = var.accepter_vpc_cidr_block
  vpc_subnet_cidr_blocks = var.accepter_vpc_subnet_cidr_blocks

  vpc_tags = {
    Name = var.accepter_vpc_name
    Side = "Accepter"
  }
}

module "security_group_ssh_icmp_vpc_b" {
  source = "./modules/aws_security_group"
  
  aws_vpc_id = module.vpc_b.vpc_id
}

module "ec2_vpc_b" {
  source = "./modules/aws_ec2"
  
  ami = var.ami_b
  subnet_id = module.vpc_b.subnet_ids[0]
  vpc_security_group_ids = [module.security_group_ssh_icmp_vpc_b.id]
  aws_key_pair_name = var.aws_key_pair_name_b
}

module "vpc_peering" {
  source = "./modules/vpc_peering"

  enabled = var.activate_peering

  requester_aws_access_key = var.requester_aws_access_key
  requester_aws_secret_key = var.requester_aws_secret_key
  requester_region         = var.requester_region

  accepter_aws_access_key = var.accepter_aws_access_key
  accepter_aws_secret_key = var.accepter_aws_secret_key
  accepter_region         = var.accepter_region

  aws_token = var.aws_token

  requester_vpc_id = module.vpc_a.vpc_id
  accepter_vpc_id  = module.vpc_b.vpc_id

  requester_peer_tags = {
    Name = "VPC peering between ${module.vpc_a.vpc_name} and ${module.vpc_b.vpc_name}"
    Side = "Requester"
  }

  accepter_peer_tags = {
    Name = "VPC peering between ${module.vpc_a.vpc_name} and ${module.vpc_b.vpc_name}"
    Side = "Accepter"
  }
}
