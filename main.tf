terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "vpc_a" {
  source = "./modules/aws_vpc"

  vpc_cidr_block         = var.requester_vpc_cidr_block
  vpc_subnet_cidr_blocks = var.requester_vpc_subnet_cidr_blocks

  vpc_tags = {
    Name = var.requester_vpc_name
    Side = "Requester"
  }
}

module "security_group_ssh_icmp_vpc_a" {
  source = "./modules/aws_security_group"

  vpc_id = module.vpc_a.vpc_id
}

module "ec2_vpc_a" {
  source = "./modules/aws_ec2"

  ami                    = var.ami_a
  subnet_id              = module.vpc_a.subnet_ids[0]
  vpc_security_group_ids = [module.security_group_ssh_icmp_vpc_a.sg_id]
  aws_key_pair_name      = var.aws_key_pair_name_vpc_a
}

module "vpc_b" {
  source = "./modules/aws_vpc"

  providers = {
    aws = aws.west
  }

  vpc_cidr_block         = var.accepter_vpc_cidr_block
  vpc_subnet_cidr_blocks = var.accepter_vpc_subnet_cidr_blocks

  vpc_tags = {
    Name = var.accepter_vpc_name
    Side = "Accepter"
  }
}

module "security_group_ssh_icmp_vpc_b" {
  source = "./modules/aws_security_group"

  providers = {
    aws = aws.west
  }

  vpc_id = module.vpc_b.vpc_id
}

module "ec2_vpc_b" {
  source = "./modules/aws_ec2"

  providers = {
    aws = aws.west
  }

  ami                    = var.ami_b
  subnet_id              = module.vpc_b.subnet_ids[0]
  vpc_security_group_ids = [module.security_group_ssh_icmp_vpc_b.sg_id]
  aws_key_pair_name      = var.aws_key_pair_name_vpc_b
}

module "vpc_peering" {
  source = "./modules/vpc_peering"

  providers = {
    aws      = aws
    aws.west = aws.west
  }

  enabled = var.activate_peering

  requester_vpc_id = module.vpc_a.vpc_id
  accepter_vpc_id  = module.vpc_b.vpc_id

  region_b = var.region_b

  requester_peer_tags = {
    Name = "VPC peering between ${module.vpc_a.vpc_name} and ${module.vpc_b.vpc_name}"
    Side = "Requester"
  }

  accepter_peer_tags = {
    Name = "VPC peering between ${module.vpc_a.vpc_name} and ${module.vpc_b.vpc_name}"
    Side = "Accepter"
  }
}